//
//  UserProfileView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct UserProfilesView: View {
    @Binding var users: [User]
    @State private var isPresentingAddUserView = false
    
    var body: some View {
        VStack{
            HeaderView(title: "User Profiles")
            
            NavigationStack {
                List($users, editActions: .delete) { $user in
                    NavigationLink (destination: DetailView(user: $user)) {
                        CardView(user: user)
                    }
                    .listRowBackground(Color.clear)
                }
                .padding(.top, -20)
                .toolbar {
                    Button(action: {isPresentingAddUserView = true },
                           label: {
                        HStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color.white)
                        }
                        .frame(width: 30, height: 30)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.top, 10)
                    }
                    )
                    .padding(.trailing, 20)
                }
                .accessibilityLabel("Create new user")
                .scrollContentBackground(.hidden)
            }
            .sheet(isPresented: $isPresentingAddUserView, content: {
                NewUserSheet(users: $users, isPresentingAddUserView: $isPresentingAddUserView)
            })
        }
    }
}

#Preview {
    UserProfilesView(users: .constant(User.sampleData))
}

/*
 resource for all user profile views (parent and child):
 https://developer.apple.com/tutorials/app-dev-training
 */
