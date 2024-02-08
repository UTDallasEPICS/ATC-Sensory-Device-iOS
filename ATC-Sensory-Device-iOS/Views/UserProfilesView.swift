//
//  UserProfileView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct UserProfilesView: View {
    @Binding var users: [User]
    
    var body: some View {
        VStack{
            HeaderView(title: "User Profiles")
            
            NavigationStack {
                List($users) { $user in
                    NavigationLink (destination: DetailView(user: $user)) {
                        CardView(user: user)
                    }
                    .listRowBackground(Color.clear)
                }
                .padding(.top, -20)
                .toolbar {
                    Button(action: {},
                           label: { Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                            .foregroundColor(Color("BlueTheme"))
                    }
                    )
                }
                .accessibilityLabel("Create new user")
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    UserProfilesView(users: .constant(User.sampleData))
}
