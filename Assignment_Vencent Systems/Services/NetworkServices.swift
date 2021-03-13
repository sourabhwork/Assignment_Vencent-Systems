//
//  NetworkServices.swift
//  Assignment_Vencent Systems
//
//  Created by Sourabh Kumbhar on 13/03/21.
//  Copyright © 2021 Sourabh Kumbhar. All rights reserved.
//

import Foundation

class NetworkServices {
        
    func fetchData(completion: @escaping(_ success: Bool, _ message: String?, _ response: Array<User>?)-> ()) {
        // Create url
        let urlString = ConstantURL.appURL
        guard let url = URL(string: urlString) else {
            completion(false, ConstantKey.urlInvalid, nil)
            return
        }
        // Create url request
        var requst = URLRequest(url: url)
        
        // Set http method
        requst.httpMethod = "GET"
        
        // Create Session
        let session = URLSession.shared
        
        // Create datatask
        let dataTask = session.dataTask(with: requst, completionHandler: {
            (data, response, error)->Void in
            
            if error != nil {
                completion(false, error?.localizedDescription, nil)
                return
            }
            if let convertData = data {
                do {
                    // Parsing data using codable and pass data to viewcontroller through completion handler
                    let responseDataArray = try JSONDecoder().decode([User].self, from: convertData)                    
                    completion(true, nil, responseDataArray)
                    return
                } catch let error {
                    // Handle error
                    completion(false, error.localizedDescription, nil)
                    return
                }
            } else {
                // Handle error
                completion(false, ConstantKey.somethingWentWrong, nil)
                return
            }
        }).resume()
    }
}
