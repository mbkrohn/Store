//
//  Auth.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

struct Auth{
    
    enum AuthVals :String {
        case firstname
        case lastname
        case username
        case password
        case userIsRegistered
        case usersToken
        case tokenExpiration
    }
    
    let registerUrl = "https://balink-ios-learning.herokuapp.com/api/v1/auth/register"
    let loginUrl = "https://balink-ios-learning.herokuapp.com/api/v1/auth/login"
    let productsUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products"
    let createBasketUrl = "https://balink-ios-learning.herokuapp.com/api/v1/products/basket"
    
    func HasRegistered()->Bool{
        return UserDefaults.standard.bool(forKey: AuthVals.userIsRegistered.rawValue)
    }
    
    func register(newusername uname: String, firstName fname :String, lastname lname:String, password pwd : String){
        sendRequest(url: registerUrl, values: [AuthVals.firstname.rawValue:fname,
                                               AuthVals.lastname.rawValue:lname,
                                               AuthVals.username.rawValue:uname,
                                               AuthVals.password.rawValue:pwd])
    }
    
    func login(username uname: String, password pwd : String ){
        sendRequest(url: loginUrl, values: [AuthVals.username.rawValue:uname, AuthVals.password.rawValue:pwd])
    }
    
    func isValidPassword(password pwd : String)->Bool {
        return true
    }
    
    func sendRequest(url urlString: String, values params: [String:String]){
        
        let url = URL(string: urlString)
        
        guard let requestUrl = url else {fatalError()}
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        // Build the body of the request
        let body = params.map{ $0.0 + "=" + $0.1 }.joined(separator: "&")
        	
        // Set HTTP Request Body
        request.httpBody = body.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error while sending request: \(error)")
                return
            }
            
            if let safeData = data {
                do {
                    let token = try JSONDecoder().decode(AccessToken.self, from: safeData)
                    SaveTokenToDefaults(token)
                } catch {
                    print("Error while trying to decode token: \(error)")
                }
            }
        }
        task.resume()
    }
        
    func SaveTokenToDefaults(_ token : AccessToken){
        UserDefaults.standard.set(true, forKey: AuthVals.userIsRegistered.rawValue)
        UserDefaults.standard.set(token.access_token, forKey: AuthVals.usersToken.rawValue)
        UserDefaults.standard.set(Date().addingTimeInterval(10*60), forKey: AuthVals.tokenExpiration.rawValue)
    }
}
    
struct AccessToken : Codable {
        let access_token : String
}


    
    
