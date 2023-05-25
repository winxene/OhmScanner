//
//  AppearanceModel.swift
//  soldir
//
//  Created by Winxen Ryandiharvin on 23/05/23.
//

import SwiftUI

struct AppearanceModel {
    static func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
