//
//  LeadingIconLabelStyle.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 1/31/24.
//

import Foundation
import SwiftUI

struct LeadingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}

extension LabelStyle where Self == LeadingIconLabelStyle {
    static var leadingIcon: Self { Self() }
}
