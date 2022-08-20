//
//  FirebaseAuthService.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 15.08.2022.
//

import Foundation

import FirebaseAuth
import Firebase

class AuthService {
    static let insance = AuthService()
    
    var loggedIn : Bool {
        get{
            UserDefaults.standard.bool(forKey: "loggedIn")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "loggedIn")
        }
    }

    var storedUserEmail : String? {
        get{
            UserDefaults.standard.value(forKey: "userEmail") as? String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "userEmail")
        }
    }
    var storedUserName : String? {
        get{
            UserDefaults.standard.value(forKey: "userName") as? String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }


    
    func createUser(withEmail email : String, andPassword password: String, andUsername username: String, completion : @escaping(_ success: Bool, _ error : Error?)->()) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if error == nil {
                storedUserName = username
                storedUserEmail = (authResult?.user.email)!
                loggedIn = true
                
                Firestore.firestore().collection(USER).addDocument(data: [
                    "email" : email,
                    "password" : password,
                    "username" : username,
                    "uid" : authResult?.user.uid
                ]){ error in
                    if error != nil {
                        print("Data couldn't be saved to the Firestore", error?.localizedDescription ?? "Error")
                    } else {
                        print("hoooray")
                    }
                }

                completion(true, nil)
            } else {
                print(error ?? "Couldn't create user")
                completion(false, error)
            }
        }
    }
   
    
    func loginUser(withEmail email: String, andPassword password: String, completion : @escaping(_ success: Bool, _ error: Error?)->()){
        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
            if error == nil {
                Firestore.firestore().collection(USER).getDocuments { query, error in
                    guard let document = query?.documents else {return}
                    for i in document {
                        if i["uid"] as! String  == (authResult?.user.uid)!  {
                            if let currentUsername = i["username"] as? String {
                                if let currentUserEmail = i["email"] as? String {
                                    self.storedUserName = currentUsername
                                    self.storedUserEmail = currentUserEmail
                                    self.loggedIn = true
                                    completion(true, nil)
                                    return
                                }
                            }
                            
                        } else {
                            print("No saved user data found")
                        }
                    }
                }
                
            } else {
                print(error ?? "Error")
                completion(false, error)
            }
            
        }
    }
    
    func logoutUser(completion: @escaping(_ status : Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            self.loggedIn = false
            self.storedUserEmail = ""
            self.storedUserEmail = ""
            print(self.loggedIn)
            completion(true)
            
        } catch {
            completion(false)
            print("SignOut failed")
        }
    }


}
