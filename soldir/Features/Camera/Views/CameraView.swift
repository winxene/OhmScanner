//
//  CameraView.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 21/05/23.
//

import SwiftUI
import Vision

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @State private var capturedImage: UIImage?
    @State private var resistorValue: String?
    
    func handleFrame(_ frame: UIImage) {
        capturedImage = frame
        guard let ciImage = frame.ciImage else {
            print("Failed to convert image")
            return
        }
        
        let requestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            let model = try VNCoreMLModel(for: ResistorValueClassification_V1(configuration: MLModelConfiguration()).model)
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
                    print("Classification failed")
                    return
                }
                
                self.resistorValue = topResult.identifier
            }
            
            try requestHandler.perform([request])
        } catch {
            print("Failed to perform image classification: \(error)")
        }
    }

    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        if context != nil {
            return context.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
    
    func processObservation(_ observation: VNImageAlignmentObservation) {

        guard let modelClassifier = try?
                ResistorValueClassification_V1(configuration: MLModelConfiguration()) else {
            return
        }

        let ciImageInput = CIImage(image: capturedImage!)
        
        guard let input = try? ResistorValueClassification_V1Input(imageWith: convertCIImageToCGImage(inputImage: ciImageInput!)) else {
            return
        }
        
        guard let prediction = try? modelClassifier.prediction(input: input) else {
            return
        }

        let filtered = prediction.classLabelProbs.filter { element in
            element.value > 0.5
        }
        resistorValue = String(describing: filtered)
        print(resistorValue ?? "0")
    }
    
    var body: some View {
        VStack (alignment: .center){
            CameraViewModel()
                .onFrameCaptured { frame in
                    print(resistorValue ?? "0")
                    handleFrame(frame)
                }
                .frame(width: 300, height: 300)
                .cornerRadius(10)
                .padding(.vertical)
            Text(resistorValue ?? "0")
        }.toolbar {
            Button("Done") {
                dismiss()
            }
        }
    }
}
