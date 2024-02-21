//
//  UserStore.swift
//  ATC-Sensory-Device-iOS
//
//  Created by UTDesign on 2/14/24.
//

import SwiftUI

//ATC-Sensory-Device-iOS will load and save users to a file in the app user's Documents folder

@MainActor  //mutations of the propertyies will occur on the main actor.
class UserStore: ObservableObject {
    @Published var users: [User] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("PortableHugsUserProfiles.data")
    }
    
    //method to load data
    func load() async throws{
        let task = Task<[User], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let userProfiles = try JSONDecoder().decode([User].self, from: data)
            return userProfiles
        }
        let users = try await task.value
        self.users = users
    }
    
    //method to save data to a file in the user's documents
    func save(users: [User]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(users)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}

/*
 Source: developer.apple.com/tutorials/app-dev-training/persisting-data
 */
