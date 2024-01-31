//
//  EditProfileView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 1/29/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var user = User.emptyUser
    
    var body: some View {
        Text("Edit Profile")
            .font(.title)
            .bold()
            
        Form {
            TextField("Name", text: $user.name, prompt: Text("Name").foregroundColor(Color("GreenTheme")))
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("GreenTheme"), lineWidth: 2)
                }
        }
        .padding(.top, -10)
        .padding(.bottom, 10)
        .frame(width: 344, height: 130)
        .scrollContentBackground(.hidden)
        
        
        VStack {
            InteractiveSliderView(valToSave: $user.holdTime,
                                  sliderValue: 1.0,
                                  sliderDescription: "Hold Time",
                                  displaySpec: 0,
                                  stepSize: 1,
                                  colorGradient: [.green, .blue],
                                  minValue: 1,
                                  maxValue: 30,
                                  unit: "s"
            )
            VStack {
                InteractiveSliderView(valToSave: $user.pressure,
                                      sliderValue: 14.7,
                                      sliderDescription: "Pressure",
                                      displaySpec: 1,
                                      stepSize: 0.1,
                                      colorGradient: [.green, .yellow, .red],
                                      minValue: 14.7,
                                      maxValue: 15.7,
                                      unit: "psi"
                )
                
                HStack {
                    Text("**L**")
                        .offset(x:-110)
                    Text("**M**")
                        .offset(x:5)
                    Text("**H**")
                        .offset(x:110)
                }
                .padding(.top, -50)
            }
            .offset(y: -15)
        }
        
        Button(action: {
            print("Hello World")
            print("\($user.name)")
            print("\($user.holdTime)")
            print("\($user.pressure)")
        },
        label: {
            HStack {
                Text("Save Edits")
                    .bold()
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 120, height: 60)
            .foregroundColor(.black)
            .background(Color("BlueTheme"))
            .cornerRadius(25)
        })
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}
