//
//  ErrorView.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/14/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occured!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
        .cornerRadius(16)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Dismiss"){
                    dismiss()
                }
                .foregroundColor(.red)
            }
        }
        }
    }
}

struct ErrorView_Previews: PreviewProvider{
    enum SampleError: Error{
        case errorRequired
    }
    
    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired,
                     guidance: "You can safely ignore this error.")
    }
    
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}

/*
 * Sources/References
    Referenced iOS App Dev Tutorials' Scrumdinger app development
    https://developer.apple.com/tutorials/app-dev-training

 * to get to this app's sandbox container type the following into the terminal
   (if the bundle identifier changes, change EPICS.Portable-Hugs to the new identififer).
 * xcrun simctl get_app_container booted EPICS.Portable-Hugs data
 * open -a Finder [file path from previous command]
 * navigate to the .data file in the Documents folder
 */


