//
//  ContentView.swift
//  ATC Sensory Cuff
//
//  Created by UTDesign on 9/17/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bleController = BLEController()
    var body: some View {
            ZStack {
                Color("ThemeColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, World!")
                        .fontWeight(.bold)
                        .font(.title2)
                        .foregroundColor(.accentColor)
                        .multilineTextAlignment(.center)
                    Button(action: {bleController.connectToSensor()}){
                        Text("Connect")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.accentColor)
                            .background(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                                .background(Color.white.cornerRadius(25)))
                    }
                    Button(action: {bleController.connectToSensor()}){
                        Text("Disconnect")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.accentColor)
                            .background(RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                                .background(Color.white.cornerRadius(25)))
                    }
                }.padding()
            }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
