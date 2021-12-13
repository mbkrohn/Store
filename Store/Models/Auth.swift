//
//  Auth.swift
//  Store
//
//  Created by BA Link Ltd on 13/12/2021.
//

import UIKit

struct Auth{
    
    enum AuthValues :String {
        case firstname
        case lastname
        case username
        case password
    }
    
    let postRegister = "https://balink-ios-learning.herokuapp.com/api/v1/auth/register"
    let postLogin = "https://balink-ios-learning.herokuapp.com/api/v1/auth/login"
    let getProducts = "https://balink-ios-learning.herokuapp.com/api/v1/products"
    let postCreateBasket = "https://balink-ios-learning.herokuapp.com/api/v1/products/basket"
    
    
//    {
//      "firstname": "Elie",
//      "lastname": "Drai",
//      "username": "john.drai@gmail.com",
//      "password": "this.is.a.password"
//    }
//

    var token : String?

    var tokenTime : Date
    
    func isValidUser()->bool{
        return true
    }
    
    func registerp(newusername uname: String, firstName fname :String, lastname lname:String, password pwd : String ) ->bool{
        
    }
    
    func login(username uname: Stringpassword pwd : String ) ->Bool{
        
    }
    
    func isValidPassword(password pwd : String)->Bool {
        return true
    }
    
    func sendRequest(_ urlString: String, values params: [String:String]){
        
        let url = URL(string: urlString)
            
        
        guard let requestUrl = url else { fatalError("Failed building url") }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        // Build the body of the request
        var postString = ""
        for param in params.keys {
            postString += String("\(param)=\(params[param])&")
        }
        
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for Error
                if let error = error {
                    print("Error took place \(error)")
                    return
                }
         
            if let token = JSONDecoder.decode(AccessToken.self, from: data){
                SaveTokenToDefaults(token)
        }
        task.resume()
    }
        
        
        func SaveTokenToDefaults(token){
            UserDefaults.standard.set(token, forKey: "UserToken")
            UserDefaults.standard.set(token, forKey: "UserToken")
        }

}

    
    
class AccessToken : Decodable {
    access_token : String
}
