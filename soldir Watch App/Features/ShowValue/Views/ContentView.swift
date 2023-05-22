//
//  ContentView.swift
//  soldir Watch App
//
//  Created by Winxen Ryandiharvin on 19/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Resistance").fontWeight(.bold).padding(.bottom, 16)
            HStack(alignment: .center, spacing: 12){
                Text("100")
                Text("Ω")
            }
        }
        .padding()
    }
}
