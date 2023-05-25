//
//  ContentView.swift
//  soldir Watch App
//
//  Created by Winxen Ryandiharvin on 19/05/23.
//

import SwiftUI
import WatchKit
import WatchConnectivity

class SessionDelegate: NSObject, WCSessionDelegate {
    weak var viewModel: ContentViewModel?
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let receivedResistorValue = message["resistorValue"] as? String {
            DispatchQueue.main.async { [weak self] in
                self?.viewModel?.resistorValue = receivedResistorValue
            }
        }
    }
}

class ContentViewModel: ObservableObject {
    @Published var resistorValue: String = ""
}

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @State private var sessionDelegate: SessionDelegate?

    var body: some View {
        VStack {
            Text("Resistance").fontWeight(.bold).padding(.bottom, 16)
            HStack(alignment: .center, spacing: 12){
                Text(viewModel.resistorValue)
                Text("Ω")
            }
        }
        .padding()
        .onAppear {
            if WCSession.isSupported() {
                let session = WCSession.default
                sessionDelegate = SessionDelegate(viewModel: viewModel)
                session.delegate = sessionDelegate
                session.activate()
            }
        }
    }
}
