//
//  AllActionsView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/21/23.
//

import SwiftUI

struct AllActionsView: View {    
    var body: some View {
        NavigationView {
            VStack {
                //header
                VStack {
                    HeaderView(title: "Let's Get Started")
                    Text("Where would you like to begin?")
                        .bold()
                        .padding(.bottom, 30)
                }
                .offset(y: -70)
                
                //go to user profiles
                NavigationLink(
                    destination: AllProfilesView(),
                    label: {
                        HStack {
                            Image(systemName: "person.2.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 45, height: 45)
                                .offset(x: -25)
                            Text("User Profiles")
                                .bold()
                                .foregroundColor(.black)
                                .font(.title)
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .offset(x: 20)
                        }
                        .frame(width: 334, height: 85)
                        .background(Color("BlueTheme"))
                        .cornerRadius(25)
                        .offset(y: -20)
                        .padding(.bottom, 50)
                    }
                )
                
                //go to free run mode
                NavigationLink(
                    destination: FreeRunView(),
                    label: {
                        HStack {
                            Image(systemName: "playpause.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .offset(x: -51)
                            Text("Free Run")
                                .bold()
                                .foregroundColor(.black)
                                .font(.title)
                            
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .offset(x: 45)
                        }
                        .frame(width: 334, height: 85)
                        .background(Color("GreenTheme"))
                        .cornerRadius(25)
                        .offset(y: -20)
                        .padding(.bottom, 50)
                    }
                )
                
                //go to cycle run mode
                NavigationLink(
                    destination: CycleRunView(),
                    label: {
                        HStack {
                            Image(systemName: "repeat.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .offset(x: -44)
                            Text("Cycle Run")
                                .bold()
                                .foregroundColor(.black)
                                .font(.title)
                            Image(systemName: "arrow.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .offset(x: 35)
                        }
                        .frame(width: 334, height: 85)
                        .background(Color("BlueTheme"))
                        .cornerRadius(25)
                        .offset(y: -20)
                    }
                )
                
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
                .offset(x: 140, y: 75)
            }
            .navigationBarTitle("Back to Start", displayMode:.inline)
            .navigationBarHidden(true)
        }//end of NavigationView
        .accentColor(Color(.label))
    }
}

#Preview {
    AllActionsView()
}
