//
//  CameraViewModel.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 24/05/23.
//

import UIKit
import SwiftUI
import AVFoundation

struct CameraViewModel: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        var parent: CameraViewModel
        
        init(_ parent: CameraViewModel) {
            self.parent = parent
        }
        
        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            // Handle the captured frame here
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
            let uiImage = UIImage(ciImage: ciImage)
            
            // Pass the captured frame to the parent view
            parent.handleFrame(uiImage)
        }
    }
    
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var coordinator: Coordinator?
    
    private var frameHandler: ((UIImage) -> Void)?
    
    private var zoomScale: CGFloat = 1.0 {
        didSet {
            guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
                return
            }
            
            do {
                try videoCaptureDevice.lockForConfiguration()
                defer { videoCaptureDevice.unlockForConfiguration() }
                
                let maxZoomFactor = videoCaptureDevice.activeFormat.videoMaxZoomFactor
                let clampedZoomScale = max(1.0, min(maxZoomFactor, zoomScale))
                
                videoCaptureDevice.videoZoomFactor = clampedZoomScale
            } catch {
                print("Failed to set zoom scale: \(error)")
            }
        }
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return view
        }
        
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            return view
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }
        
        videoOutput.setSampleBufferDelegate(context.coordinator, queue: DispatchQueue(label: "camera_frame_queue"))
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePinchGesture(_:)))
        view.addGestureRecognizer(pinchGesture)
        
        captureSession.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // No need to update anything in this example
    }
    
    func handleFrame(_ frame: UIImage) {
        if let safeHandler = frameHandler {
            safeHandler(frame)
        } else {
            print("frameHandler is not defined!")
        }
    }
    
    func onFrameCaptured(_ handler: @escaping (UIImage) -> Void) -> Self {
        var updatedView = self
        updatedView.frameHandler = handler
        
        return updatedView
    }
    
    func zoom(withScale scale: CGFloat) -> Self {
        var updatedView = self
        updatedView.zoomScale = scale
        
        return updatedView
    }
}

extension CameraViewModel.Coordinator {
    @objc func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        guard let previewView = parent.previewLayer?.previewView else {
            return
        }
        
        switch gesture.state {
        case .changed, .ended:
            let scale = gesture.scale
            let zoomScale = parent.zoomScale * scale
            parent.zoomScale = zoomScale
            
            gesture.scale = 1.0
            
            // Reset the gesture's scale to 1.0 to avoid exponential scaling
            
        default:
            break
        }
    }
}

extension AVCaptureVideoPreviewLayer {
    var previewView: UIView? {
        return self.superlayer?.superlayer as? UIView
    }
}
