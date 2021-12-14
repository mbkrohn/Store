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
    
    func register(firstName fname :String, lastname lname:String,username uname: String, password pwd : String)-> Bool{
        let request = createRequest(url: registerUrl,
                                    values: [AuthVals.firstname.rawValue:fname,
                                             AuthVals.lastname.rawValue:lname,
                                             AuthVals.username.rawValue:uname,
                                             AuthVals.password.rawValue:pwd])
        return sendRequest(with: request)
    }
    
    func login(username uname: String, password pwd : String )->Bool{
        let request = createRequest(url: loginUrl, values: [AuthVals.username.rawValue:uname, AuthVals.password.rawValue:pwd])
        return sendRequest(with: request)
    }
    
    func isValidPassword(password pwd : String)->Bool {
        return true
    }
    
    fileprivate func createRequest(url urlString: String, values params: [String:String])->URLRequest{
        
        let url = URL(string: urlString)
        
        guard let requestUrl = url else {fatalError()}
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        let body = params.map{ $0.0 + "=" + $0.1 }.joined(separator: "&")
        print(body)
            
        request.httpBody = body.data(using: String.Encoding.utf8);
        return request
    }
    
    
    fileprivate func sendRequest(with request :URLRequest) -> Bool{
        var result = true
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                result = false
                print("Error while sending request: \(error)")
                return
            }
            
            if let safeData = data {
                do {
                    let token = try JSONDecoder().decode(AccessToken.self, from: safeData)
                    SaveTokenToDefaults(token)
                    result = true
                } catch {
                    print("Error while trying to decode token: \(error)")
                }
            }
        }
        task.resume()
        return result
    }
        
    func SaveTokenToDefaults(_ token : AccessToken){
        UserDefaults.standard.set(true, forKey: AuthVals.userIsRegistered.rawValue)
        UserDefaults.standard.set(token.access_token, forKey: AuthVals.usersToken.rawValue)
        UserDefaults.standard.set(Date().addingTimeInterval(10*60), forKey: AuthVals.tokenExpiration.rawValue)
    }
}
    
struct AccessToken : Decodable {
        let access_token : String
}


    
    
