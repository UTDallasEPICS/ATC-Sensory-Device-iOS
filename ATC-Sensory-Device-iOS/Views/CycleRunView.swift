//
//  CycleRunView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct CycleRunView: View {
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Cycle Run")
                    .offset(y: -80)
                
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
                    .offset(y: -30)
                    
                    
                    //start cycle
                    VStack {
                        //send deflate command
                        Button(
                            action: {/*NEEDS TO BE COMPLETED. WRITE TO ESP*/},
                            label: {
                                HStack {
                                    Text("Start")
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

                        Button(
                            action: {/*NEEDS TO BE COMPLETED. WRITE TO ESP*/},
                            label: {
                                HStack {
                                    Text("Stop")
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
                        .offset(y: 20)
                    }
                    .offset(y: 10)
                }
                
                //swift plot
                RealTimePlotView()
                    .offset(y: 60)
                
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
                .offset(x: 140, y: 90)
            }//end of VStack
            .navigationBarTitle("Cycle Run", displayMode:.inline)
            .navigationBarHidden(true)
        }//end of NavigationView
        .accentColor(Color(.label))
    }
}

#Preview {
    CycleRunView()
}
