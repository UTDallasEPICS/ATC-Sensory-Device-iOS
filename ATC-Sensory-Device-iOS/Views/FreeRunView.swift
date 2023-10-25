//
//  FreeRunView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct FreeRunView: View {
    @State var holdTime: Double = 1.0
    @State var targetPressure: Double = 14.0
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Free Run")
                    .offset(y: -20)
                
                VStack {
                    //connect to device
                    Button(
                        action: {},
                        label: {
                            HStack {
                                Image(systemName: "iphone.gen3.radiowaves.left.and.right.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .offset(x: -10)
                                Text("Connect to Device")
                                    .bold()
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 250, height: 70)
                            .foregroundColor(.black)
                            .background(Color("BlueTheme"))
                            .cornerRadius(25)
                        }
                    )
                    .offset(y: -10)
                    
                    
                    VStack {
                        InteractiveSlider(valToSave: $holdTime, sliderDescription: "Hold Time", displaySpec: 0, stepSize: 1, colorGradient: [.green, .blue], minValue: 1, maxValue: 30, unit: "s")
                        
                        VStack {
                            InteractiveSlider(valToSave: $targetPressure, sliderDescription: "Target Pressure", displaySpec: 1, stepSize: 0.1, colorGradient: [.green, .yellow, .red], minValue: 14.0, maxValue: 15.3, unit: "psi")
                            
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
                    
                    //send inflate command
                    HStack {
                        //send deflate command
                        Button(
                            action: {/*NEEDS TO BE COMPLETED. WRITE TO ESP*/},
                            label: {
                                HStack {
                                    Text("Deflate")
                                        .bold()
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 120, height: 60)
                                .foregroundColor(.black)
                                .background(Color("BlueTheme"))
                                .cornerRadius(25)
                            }
                        )
                        .offset(x:-50)
                        Button(
                            action: {/*NEEDS TO BE COMPLETED. WRITE TO ESP*/},
                            label: {
                                HStack {
                                    Text("Inflate")
                                        .bold()
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 120, height: 60)
                                .foregroundColor(.black)
                                .background(Color("GreenTheme"))
                                .cornerRadius(25)
                            }
                        )
                        .offset(x:50)
                    }
                    .offset(y: -40)
                }
                .offset(y:10)
                //swift plot
                RealTimePlotView()
                
                //go to settings
                HStack {
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            VStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 58, height: 58)
                            .background(Color.black)
                            .cornerRadius(25)
                        }
                    )
                }
                .offset(x: 140, y: 10)
            }//end of VStack
            .navigationBarTitle("Free Run", displayMode:.inline)
            .navigationBarHidden(true)
        }//end of NavigationView
        .accentColor(Color(.label))
    }
}

#Preview {
    FreeRunView()
}
