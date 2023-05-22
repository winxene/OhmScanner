//
//  OnboardingCarouselCard.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 22/05/23.
//

import SwiftUI

struct OnboardingCard: View {
    
    var imageName: String
    var titleText: String
    var descriptionText: String
    
    var body: some View {
        GeometryReader {
            geometry in
            VStack(alignment: .center){
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: geometry.size.width * 0.71,
                        height: geometry.size.height * 0.33
                    )
                    .padding(.bottom, 48)
                Text(titleText)
                    .font(
                        .system(size: 24, weight: .bold)
                    ).multilineTextAlignment(.center)
                    .padding(.bottom, 32)
                Text(descriptionText)
                    .font(
                        .system(size: 12, weight: .light)
                    ).multilineTextAlignment(.center)
            }.padding(.horizontal, geometry.size.width * 0.12)
        }
    }
}
