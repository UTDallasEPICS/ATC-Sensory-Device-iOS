//
//  DetailEditView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/6/24.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var user: User
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $user.nameAsString, prompt: Text("Name").foregroundColor(Color("GreenTheme")))
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
                InteractiveSliderView(valToSave: $user.holdTimeAsDouble,
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
                    InteractiveSliderView(valToSave: $user.pressureAsADouble,
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
                    .padding(.bottom, -15)
                }
            }
            .padding(.bottom, -50)
        }
        .offset(y:-25)
    }
}

#Preview {
    DetailEditView(user: .constant(User.sampleData[0]))
}
