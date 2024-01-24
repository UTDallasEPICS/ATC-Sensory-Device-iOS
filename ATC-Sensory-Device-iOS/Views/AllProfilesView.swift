//
//  UserProfileView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct AllProfilesView: View {
    var body: some View {
        VStack {
            Image(systemName: "applepencil.and.scribble")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom, 10)
            VStack {
                Text("This page is still under construction")
                Text("Check back later for updates :)")
            }
            .bold()
            .italic()
        }
        .offset(y:-20)
    }
}

#Preview {
    AllProfilesView()
}
