//
//  RoundedRectangleButton.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 22/05/23.
//

import SwiftUI

struct NavigationButton<Destination: View>: View {
    let destination: Destination
    let label: String
    let geometry: GeometryProxy
    
    var body: some View {
        NavigationLink {
            destination.navigationBarBackButtonHidden()
        } label: {
            Text(label)
                .font(.system(size: 24, weight: .bold))
                .frame(width: 179, height: 56)
        }.buttonStyle(.borderedProminent)
            .accentColor(.teal)
        .padding(.vertical, geometry.size.width * 0.038)
    }
}
