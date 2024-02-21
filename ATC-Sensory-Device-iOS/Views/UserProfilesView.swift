//
//  UserProfileView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/19/23.
//

import SwiftUI

struct UserProfilesView: View {
    @State private var errorWrapper: ErrorWrapper?
    @EnvironmentObject var store: UserStore
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
            .sheet(isPresented: $isPresentingAddUserView) {
                NewUserSheet(users: $users, isPresentingAddUserView: $isPresentingAddUserView)
            }
            //when user navigates away from the page, save the current list.
            .onDisappear(){
                Task {
                    do {
                        try await store.save(users: store.users)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
                print("Data Saved!")
            }
        }
        .sheet(item: $errorWrapper){
            store.users = User.sampleData
        } content: { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
        .task {
            //modifier allows asynchornous function calls
            do {
                try await store.load()
            } catch {
                errorWrapper = ErrorWrapper(error: error,
                                            guidance: "Portable Hugs will load sample data and continue")
            }
        }
    }
}


#Preview {
    UserProfilesView(users: .constant(User.sampleData))
}

/* Sources/References
   Referenced iOS App Dev Tutorials' Scrumdinger app development
   https://developer.apple.com/tutorials/app-dev-training
 */
