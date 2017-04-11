//
//  APIClient.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/11.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import Foundation
class APIClient {
    
    var keychainManager: KeychainAccessible?

    
    
    lazy var session: ToDoURLSession = URLSession.shared
    
    
    func loginUserWithName(username: String,
                           password: String,
                           completion: @escaping (Error?) -> Void) {
        
        
        let allowedCharacters = NSCharacterSet(charactersIn:"/%&=?$#+-~@<>|\\*,.()[]{}^!").inverted
        guard let encodedUsername = username.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        else {
            fatalError()
        }
        
        guard let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        else {
            fatalError()
        }
        
        
        
        guard let url = URL(string:"https://awesometodos.com/login?username=\(encodedUsername)&password=\(encodedPassword)") else
        { fatalError() }
        
        let task = session.dataTask(with: url) { (data, resonse, error) in
            do {
            let responseDict = try JSONSerialization.jsonObject(with: data!,options: []) as! [String:String]
            
            let token = responseDict["token"]!  as String
            self.keychainManager?.setPassword(password: token,
                                              account: "token")
            }catch{
                completion(error)
            }
            
        
        }
        task.resume()
        
        
    }
    
    
}
extension URLSession : ToDoURLSession {
    
}

protocol ToDoURLSession {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}





