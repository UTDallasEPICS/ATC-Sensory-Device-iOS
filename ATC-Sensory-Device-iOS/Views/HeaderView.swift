//
//  HeaderView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/21/23.
//

import SwiftUI

struct HeaderView: View {
    var title: String = "Default Title";
    
    var body: some View {
        ZStack {
            Image("logo-icon")
                .resizable()
                .cornerRadius(10)
                .frame(width: 60, height: 60)
                .offset(x: 140, y: -10)
                .padding(.bottom, 30)
            Text(title)
                .font(.system(size: 40))
                .bold()
                .offset(y: 30)
        }
        .frame(width: 400, height: 100)
    }
}

#Preview {
    HeaderView()
}
