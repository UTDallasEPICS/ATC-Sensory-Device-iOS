//
//  CardView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 1/29/24.
//

import SwiftUI

struct CardView: View {
    let user:User
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            .padding(.leading, 20)
            
            VStack (alignment: .center){
                Text("\(user.name)")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                HStack{
                    Label("\(user.pressure, specifier: "%0.1f") PSI", systemImage: "barometer")
                        .foregroundColor(.black)
                        .accessibilityLabel("\(user.pressure) PSI")
                        .labelStyle(.leadingIcon)
                        .padding(.leading, 10)
                    Spacer()
                    Label("\(user.holdTime, specifier: "%0.0f") s", systemImage: "timer")
                        .foregroundColor(.black)
                        .accessibilityLabel("\(user.holdTime) seconds")
                        .labelStyle(.trailingIcon)
                        .padding(.trailing, 10)
                }
                .font(.caption)
            }
            .padding()
        }
        .frame(width: 334, height: 85)
        .background(Color("BlueTheme"))
        .cornerRadius(25)
    }
}

#Preview {
    CardView(user: User.sampleData[2])
}

/* Sources/References
   Referenced iOS App Dev Tutorials' Scrumdinger app development
   https://developer.apple.com/tutorials/app-dev-training
 */

