//
//  DatabaseFunctions.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import FirebaseDatabase


public class DatabaseFunctions {
    
    static let sharedData = DatabaseFunctions()
    
    private let database = Database.database().reference()
    
    // check if the username or email already exists
    // obviously needs to be fully implemented
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    
    public func insertNewUser(with email: String, username: String, number: String?, name: String, completion: @escaping (Bool) -> Void) {
        
        let safeKey = email.safeDatabaseKey()
        database.child("users").child(safeKey).setValue(["username": username, "number": number, "name": name]) { error, _ in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
}
