//
//  DetailView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 1/31/24.
//

import SwiftUI

struct DetailView: View {
    @Binding var user: User
    
    @State private var isPresentingEditView = false
    @State private var editingUser = User.emptyUser
    
    var body: some View {
        Spacer()
        List {
            Section(header:
                VStack {
                Text("\(user.name)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    Text("User Presets")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Button("Edit"){
                        isPresentingEditView = true
                        editingUser = user
                    }
                    .foregroundColor(.blue)
                }
            }
            ){
                
                VStack {
                    HStack{
                        Label("Pressure", systemImage: "barometer")
                            .foregroundColor(.black)
                            .accessibilityLabel("\(user.pressure) PSI")
                            .labelStyle(.leadingIcon)
                            .padding(.leading, 10)
                        Spacer()
                        Text("\(user.pressure, specifier: "%0.1f") PSI")
                            .bold()
                    }
                    .padding(.top, 10)
                    .accessibilityElement(children: .combine)
                    Spacer()
                    HStack{
                        Label("Hold Time", systemImage: "timer")
                            .foregroundColor(.black)
                            .accessibilityLabel("\(user.holdTime) seconds")
                            .labelStyle(.leadingIcon)
                            .padding(.leading, 10)
                        Spacer()
                        Text("\(user.holdTime, specifier: "%0.0f") s")
                            .bold()
                    }
                    .padding(.bottom, 10)
                    .accessibilityElement(children: .combine)
                }
                .listRowBackground(Color("BlueTheme"))
            }
        }
        .scrollContentBackground(.hidden)
        .sheet(isPresented: $isPresentingEditView){
            NavigationView {
                DetailEditView(user: $editingUser)
                    .navigationTitle(user.name)
                    .padding(.bottom, -50)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction){
                            Button("CANCEL"){isPresentingEditView = false}
                                .foregroundColor(.red)
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("DONE"){
                                isPresentingEditView = false
                                user = editingUser
                            }
                            .foregroundColor(.blue)
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(user: .constant(User.sampleData[0]))
    }
}
