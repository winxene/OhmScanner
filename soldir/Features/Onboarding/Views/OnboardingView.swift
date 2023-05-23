//
//  OnboardingView.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 22/05/23.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationView {
            GeometryReader {
                geometry in
                VStack(alignment: .center){
                    TabView {
                        OnboardingCard(
                            imageName: "phone_icon",
                            titleText: "Know resistor value easily",
                            descriptionText: "No need to decipher color codes anymore. Just point your camera at the resistor and let us do the work. Say goodbye to manual calculations and hello to hassle-free identification.")
                        OnboardingCard(
                            imageName: "watch_icon",
                            titleText: "The convenient is within your Hand",
                            descriptionText: "No need to reach for your phone or memorize color codes. With our app for Apple Watch, simply scan any resistor and have its value displayed right on your wrist. Stay hands-free and effortlessly access resistor information wherever you are.")
                    }.tabViewStyle(PageTabViewStyle()).padding(.top, geometry.size.height * 0.174)
                        .onAppear{
                            AppearanceModel.setupAppearance()
                        }
                    NavigationButton(destination: HomeView(), label: "Next", geometry: geometry)
                }
            }
        }
    }
}
