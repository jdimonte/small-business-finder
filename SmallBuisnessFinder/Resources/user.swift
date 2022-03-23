//
//  user.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 2/24/22.
//

import FirebaseAuth


public class AuthManager {
    
    static let sharedAuth = AuthManager()
    
    func newUser(username: String, email: String, password: String, number: String?, name: String, likedBusinesses: [BusinessObject],completion: @escaping (Bool) -> Void) {
        
        // check if username is available
        // check if email is available
        
        DatabaseFunctions.sharedData.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                // create account
                // add account to database
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard error == nil, authResult != nil else {
                        completion(false)
                        return
                    }
                    // insert into database
                    DatabaseFunctions.sharedData.insertNewUser(with: email, username: username, number: number, name: name) { insert in
                        if insert {
                            completion(true)
                        }
                        else {
                            // failed to isnert into database
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                completion(false)
            }
        }
    }
    
    public func loginUser(email: String?, password: String, completion: @escaping (Bool) -> Void) {
        
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
    }
    
    // this should work
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}
