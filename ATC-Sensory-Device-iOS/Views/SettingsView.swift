//
//  SettingsView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var bleController = BLEController()
    @State var holdTime: Double = 15
        
    var body: some View {
        HeaderView(title: "Settings")
            .offset(y: -70)
        
        VStack {
            Text("Bluetooth Settings")
                .bold()
                .font(.title)
            HStack {
                Image(systemName: "iphone.gen3.radiowaves.left.and.right.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(x: -65)
                Text("Bluetooth: \n\(bleController.peripheralState)")
                    .bold()
                    .font(.system(size: 22))
                    .multilineTextAlignment(.center)
            }
            .frame(width: 348, height: 85)
            .background(Color("BlueTheme"))
            .cornerRadius(25)
            
            Button(
                action: {self.openDeviceSettings()},
                label: {
                    HStack {
                        Image(systemName: "arrow.up.forward.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .offset(x: -55)
                        Text("Open Settings")
                            .bold()
                            .font(.system(size: 22))
                    }
                    .frame(width: 348, height: 85)
                    .background(Color("GreenTheme"))
                    .cornerRadius(25)
                }
            )
        }
        .foregroundColor(.black)
        .padding(.bottom, 40)
        
        
        VStack {
            Text("General Settings")
                .bold()
                .font(.title)
                .padding(.bottom, 10)
            
            Text("Set Hold Time: \(holdTime,specifier:"%0.0f") s")
                .bold()
                .font(.headline)
            
            
            ZStack {
                //mask for gradient slider
                LinearGradient(gradient: Gradient(colors: [.green, .blue]),
                               startPoint: .leading,
                               endPoint: .trailing
                )
                .mask(
                    Slider(value: $holdTime,
                           in: 1...30,
                           step: 1,
                           minimumValueLabel: Text("1").bold(),
                           maximumValueLabel: Text("30").bold()
                    ){ Text("Title") }
                )
                
                //actual movable slider
                Slider(value: $holdTime,
                       in: 1...30,
                       step: 1,
                       minimumValueLabel: Text("1"),
                       maximumValueLabel: Text("30")
                ){ Text("Title") }
                    .accentColor(.clear)
                    .opacity(0.05)
            }
            .frame(width:300)
            Text("Value is saved automatically")
                .bold()
                .font(.footnote)
        }
        .frame(width:300, height: 200)
    }
    
    private func openDeviceSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString){
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }//end of function
    
}

#Preview {
    SettingsView()
}
