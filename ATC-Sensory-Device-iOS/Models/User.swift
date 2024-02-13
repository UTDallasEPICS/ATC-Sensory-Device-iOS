//
//  User.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 10/21/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    var name: String
    var pressure: Double
    var holdTime: Double
    
    //properties to prevent infinite recursion
    var nameAsString: String {
        get {
            String(name)
        }
        set {
            name = String(newValue)
        }
    }
    var pressureAsADouble: Double {
        get {
            Double(pressure)
        }
        set {
            pressure = Double(newValue)
        }
    }
    
    var holdTimeAsDouble: Double {
        get {
            Double(holdTime)
        }
        set {
            holdTime = Double(newValue)
        }
    }
    
    init(id: UUID = UUID(), name: String, pressure: Double, holdTime: Double){
        self.id = id
        self.name = name
        self.pressure = pressure
        self.holdTime = holdTime
    }
}

extension User {
    //provides sample data to User Object
    static let sampleData: [User] = [
        User(name: "Person 1",
             pressure: 15.4,
             holdTime: 10),
        User(name: "Person 2",
             pressure: 14.9,
             holdTime: 3),
        User(name: "Person 3",
             pressure: 15.0,
             holdTime: 27)
    ]
}

extension User {
    static var emptyUser: User {
        User(name: "Person", pressure: 14.7, holdTime: 1)
    }
}
