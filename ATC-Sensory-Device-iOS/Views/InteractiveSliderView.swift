//
//  InteractiveSlider.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/24/23.
//

import SwiftUI

struct InteractiveSliderView: View {
    @EnvironmentObject var bleController: BLEController
    
    //variable to pass a value from child to parent
    @Binding var valToSave: Double
    
    @State var sliderValue: Double = 0
    
    //values must be provided upon instansiation
    var sliderDescription: String!
    var displaySpec: Int = 0
    var stepSize: Double!
    var colorGradient: [Color]!
    var minValue: Double!
    var maxValue: Double!
    var unit: String!
    
    var body: some View {
        VStack {
            Text("Set \(sliderDescription): \(sliderValue,specifier: "%0.\(displaySpec)f") \(unit)")
                .bold()
                .font(.headline)
                .offset(x: 10)
            
            
            ZStack {
                //mask for gradient slider
                LinearGradient(gradient: Gradient(colors: colorGradient),
                               startPoint: .leading,
                               endPoint: .trailing
                )
                .mask(
                    Slider(value: $sliderValue,
                           in: (minValue...maxValue),
                           step: stepSize,
                           minimumValueLabel: Text("\(minValue, specifier: "%0.\(displaySpec)f")"),
                           maximumValueLabel: Text("\(maxValue, specifier: "%0.\(displaySpec)f")")
                          ){ Text("Title") }
                )
                
                //actual movable slider
                Slider(value: $sliderValue,
                       in: (minValue...maxValue),
                       step: stepSize,
                       onEditingChanged: { isEditing in
                                            if !isEditing{
                                                valToSave = sliderValue
                                            }
                                        },
                       minimumValueLabel: Text("\(minValue, specifier: "%0.\(displaySpec)f")"),
                       maximumValueLabel: Text("\(maxValue, specifier: "%0.\(displaySpec)f")")
                ){ Text("Title") }
                    .accentColor(.clear)
                    .opacity(0.25)
            }
            .frame(width:350)
            .padding(.top, -50)
        }
        .frame(width:300, height: 100)
    }
    
}

#Preview {
    InteractiveSliderView(valToSave: .constant(15), sliderValue: 0, sliderDescription: "Default Value", displaySpec: 1, stepSize: 1, colorGradient: [.green, .yellow, .red], minValue: 1, maxValue: 30, unit: "s")
        .environmentObject(BLEController())
}
