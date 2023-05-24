//
//  HomeView.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 22/05/23.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
            GeometryReader {
                geometry in
                VStack (alignment: .center) {
                    Spacer()
                    Text("OhmScanner")
                        .font(
                            .system(size: 36, weight: .bold)
                        ).multilineTextAlignment(.center)
                    Text("The Resistor Value Reader")
                        .font(
                            .system(size: 14, weight: .medium)
                        ).multilineTextAlignment(.center)
                        .padding(.bottom, 32)
                    Image("phone_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: geometry.size.width * 0.71,
                            height: geometry.size.height * 0.33
                        )
                        .padding(.bottom, 80)
                    Spacer()
                    Text("Ready to Scan?")
                        .font(
                            .system(size: 16, weight: .light)
                        ).multilineTextAlignment(.center)
                    Text("Let's get Started!")
                        .font(
                            .system(size: 16, weight: .light)
                        ).multilineTextAlignment(.center)
                    Spacer()
                    NavigationButton(destination: CameraView(), label: "Start!", geometry: geometry)
                }.padding(.leading, geometry.size.width * 0.150)
            }
            Spacer()
    }
}
