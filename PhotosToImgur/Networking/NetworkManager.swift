//
//  NetworkManager.swift
//  PhotosToImgur
//
//  Created by KillerBe on 29.11.2019.
//  Copyright © 2019 Khymychcrew. All rights reserved.
//

import Foundation


// Create and configure urlSession 
final class NetworkManager {
    
    static let shared = NetworkManager()
    public func uploadImage(url: String,data: Data,completion: @escaping(Codable? , Error?) -> () ) {
       
        let httpHeader = ["Authorization" : "Client-ID 82b42c967995c49"]
        guard let url = URL(string: url) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeader
        request.httpBody = data
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
         
             guard let response = response as? HTTPURLResponse,
                   (200...299).contains(response.statusCode) else {
                   completion(nil, error)
                   return
               }
            
            if let data = data {
                
                do{
                    let json = try JSONDecoder().decode(ResponseJSONModel.self, from: data)
                    //guard let link = json else {return}
                    DispatchQueue.main.async {
                        completion(json, nil)
                    }
                }catch{
                   completion(nil, error)
                }
            }
        }.resume()
        
    }
}
