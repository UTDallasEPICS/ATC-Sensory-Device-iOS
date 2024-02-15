//
//  ErrorWrapper.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/14/24.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String){
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}
