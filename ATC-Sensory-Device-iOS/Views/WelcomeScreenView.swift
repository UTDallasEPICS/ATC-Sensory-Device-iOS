//
//  WelcomeScreenView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/21/23.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.4
    
    
    var body: some View {
        if isActive {
            HomeScreenView()
        }
        else {
            VStack {
                VStack {
                    Image("p-hug-logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 347, height: 118)
                        .offset(x: 0, y: -100)
                    VStack {
                        Text("Providing relief from")
                            .font(Font.system(size: 35))
                            .italic()
                            .bold()
                        Text(" sensory overstimulation")
                            .font(Font.system(size: 35))
                            .italic()
                            .bold()
                    }
                    .frame(width: 400, height: 73, alignment: .center)
                    .foregroundColor(Color("BlueTheme"))
                    Image("atc-logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 244, height: 80)
                        .offset(x: 0, y: 100)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeScreenView()
}


/*
 @State is a property wrapper that allows us to modify values we hold inside a struct. SwiftUI can destroy and recreate the struct whenever needed without losing the state it was strong. A state should be shared with other views and should be marked as private
 @ObservedObject or @EnvironmentObject can be used when sharing a value across views to ensure all views are refreshed with the data changes
 */
