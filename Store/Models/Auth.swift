//
//  Auth.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

struct Auth{
// MARK: - Enums
    
    enum AuthVals :String {
        case firstname
        case lastname
        case username
        case password
        case userIsRegistered
        case usersToken
        case tokenExpiration
    }
    
// MARK: - URL's

    static let tokenExpirationMinutes : Double = 10
    static let registerUrl = "https://balink-ios-learning.herokuapp.com/api/v1/auth/register"
    static let loginUrl = "https://balink-ios-learning.herokuapp.com/api/v1/auth/login"

// MARK: - Properties
    
    static var firstName : String {
        get {
            if let fname = UserDefaults.standard.string(forKey: AuthVals.firstname.rawValue), Auth.isLoggedIn {
                return fname
            } else {
                return "N/A"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AuthVals.firstname.rawValue)
        }
    }
    
    static var lastName : String {
        get {
            if let lname = UserDefaults.standard.string(forKey: AuthVals.lastname.rawValue), Auth.isLoggedIn{
                return lname
            } else {
                return "N/A"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AuthVals.lastname.rawValue)
        }
    }
    
    static var userName : String {
        get {
            if let uname = UserDefaults.standard.string(forKey: AuthVals.username.rawValue), Auth.isLoggedIn {
                return uname
            } else {
                return "N/A"
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AuthVals.username.rawValue)
        }
    }
    
    static var tokenId: String? {
        get {
            // Verify that there's a token and that it's a valid one.
            // if not, than remove the token from the UserDefaults and return nil
            guard let token = UserDefaults.standard.string(forKey: AuthVals.usersToken.rawValue),
               let expire = (UserDefaults.standard.object(forKey: AuthVals.tokenExpiration.rawValue) as! Date?), expire > Date() else {
                   UserDefaults.standard.removeObject(forKey: AuthVals.usersToken.rawValue)
                   UserDefaults.standard.removeObject(forKey: AuthVals.tokenExpiration.rawValue)
                   return nil
               }
            return token
        }
        set {
            // When setting a new token register its time for 10 minutes
            UserDefaults.standard.set(newValue, forKey: AuthVals.usersToken.rawValue)
            UserDefaults.standard.set(Date().addingTimeInterval(Auth.tokenExpirationMinutes * 60), forKey: AuthVals.tokenExpiration.rawValue)
            UserDefaults.standard.set(true, forKey: AuthVals.userIsRegistered.rawValue)

        }
    }
    
    
    static var isLoggedIn : Bool {
        get {
            return tokenId != nil
        }
    }
    
    static var isRegistered : Bool{
        get {
            return UserDefaults.standard.bool(forKey: AuthVals.userIsRegistered.rawValue)
        }
    }
    
    
// MARK: - Methods
    
    func register(firstName fname :String, lastname lname:String,
                  username uname: String, password pwd : String, actionOnResponse: @escaping(Bool)->Void){
        
        let request = createRequest(url: Auth.registerUrl,
                                    values: [AuthVals.firstname.rawValue:fname,
                                             AuthVals.lastname.rawValue:lname,
                                             AuthVals.username.rawValue:uname,
                                             AuthVals.password.rawValue:pwd])
        sendRequest(with: request, actionOnResponse: actionOnResponse)
    }
    
    func login(username uname: String, password pwd : String, actionOnResponse: @escaping(Bool)->Void ){

        let request = createRequest(url: Auth.loginUrl,
                                    values: [AuthVals.username.rawValue:uname, AuthVals.password.rawValue:pwd])

        sendRequest(with: request, actionOnResponse: actionOnResponse)
    }
    
    func logout(){
        Auth.tokenId = ""
    }
    
    
    func isValidPassword(password pwd : String)->Bool {
        return true
    }
    
    
// MARK: - Private methods
    
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
    
    
    fileprivate func sendRequest(with request :URLRequest, actionOnResponse:@escaping(Bool)->Void){
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            
//            print("type of response: \(type(of: response))")
            
            // Check for Error
            if let error = error {
                print("Error while sending request: \(error)")
                return
            }

            let statusCode = (response as! HTTPURLResponse).statusCode
            let isValidStatus = isValidStatusCode(statusCode : statusCode)
            if isValidStatus {
                if let safeData = data {
                    do {
                        let token = try JSONDecoder().decode(AccessToken.self, from: safeData)
                        Auth.tokenId = token.access_token
                    } catch {
                        print("Error while trying to decode token: \(error)")
                    }
                }
            } else{
                print("Error occured \(statusCode)")
            }
            actionOnResponse(isValidStatus)
            
            
            
            
        }
        task.resume()
    }
    
    
    fileprivate func isValidStatusCode(statusCode: Int)-> Bool{
        switch statusCode{
        case 200..<299:
            return true
        default:
            return false
        }
    }
    
}

// MARK: -

struct AccessToken : Decodable {
    let access_token : String
}




