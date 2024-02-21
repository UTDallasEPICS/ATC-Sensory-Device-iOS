//
//  NewUserSheet.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/13/24.
//

import SwiftUI

struct NewUserSheet: View {
    @State private var newUser = User.emptyUser
    @Binding var users: [User]
    @Binding var isPresentingAddUserView: Bool
    
    var body: some View {
            NavigationStack{
                Text("Add New User")
                    .padding(.bottom, 20)
                    .font(.title)
                    .bold()
                DetailEditView(user: $newUser)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("Dismiss"){
                                isPresentingAddUserView = false
                            }
                            .foregroundColor(.red)
                        }
                        
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add"){
                                users.append(newUser)
                                isPresentingAddUserView = false
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .padding(.bottom, 100)
            }
    }
}

#Preview {
    NewUserSheet(users: .constant(User.sampleData), isPresentingAddUserView: .constant(true))
}

/* Sources/References
   Referenced iOS App Dev Tutorials' Scrumdinger app development
   https://developer.apple.com/tutorials/app-dev-training
 */
