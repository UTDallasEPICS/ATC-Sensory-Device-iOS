//
//  UserProfileView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct UserProfilesView: View {
    let users: [User]
    
    var body: some View {
        VStack{
            HeaderView(title: "User Profiles")
            
            NavigationStack {
                List(users) { user in
                    NavigationLink(destination: EditProfileView()) 
                    {
                        CardView(user: user)
                    }
                }
            }
            .toolbar {
                Button(action: {}, label: {Image(systemName: "plus")})
            }
            .accentColor(Color(.label))
            
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
                .accessibilityLabel("Settings")
            }
        }
    }
}

#Preview {
    UserProfilesView(users: User.sampleData)
}
