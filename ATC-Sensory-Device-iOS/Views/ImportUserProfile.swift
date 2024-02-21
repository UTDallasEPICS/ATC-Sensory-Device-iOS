//
//  ImportUserProfile.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/20/24.
//

import SwiftUI

struct ImportUserProfile: View {
    @Binding var users: [User]
    @Binding var isPresentingAllUsersView: Bool
    @Binding var selectedUser: User
    @State private var errorWrapper: ErrorWrapper?
    @EnvironmentObject var store: UserStore
    
    var body: some View {
        VStack {
            Spacer()
            //display list of all available users
            Button("Cancel"){
                isPresentingAllUsersView = false
            }
            .foregroundColor(.red)
            .offset(x: -150)
            
            Text("Select a User Profile")
                .font(.title)
                .bold()
                .padding(.bottom, -20)
                .padding(.top, 20)
            
            List($users){$user in
                HStack {
                    CardView(user: user)
                }
                .onTapGesture {
                    print("Selected")
                    selectedUser = user
                    isPresentingAllUsersView = false
                }
            }
            .scrollContentBackground(.hidden)
        }
        .padding(.top, 10)
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
    ImportUserProfile(users: .constant(User.sampleData),
                      isPresentingAllUsersView: .constant(true),
                      selectedUser: .constant(User.sampleData[0]))
}
