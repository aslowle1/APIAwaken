//
//  APIEndPoint.swift
//  APIAwakens
//
//  Created by Andros Slowley on 1/30/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import Foundation

typealias JSONData = (AnyObject?, URLResponse?, NSError?)
protocol Endpoint {
    var baseURL: String { get set }
    var path: String { get set }
    var queryItems: [URLQueryItem]? {get set}
    var components: NSURLComponents { get set }
    var request: URLRequest { get set }
    
    var session: URLSession {get set}
    var configuration: URLSessionConfiguration { get set }
}

extension Endpoint {
    
    func grabData(request2: URLRequest, completion : @escaping (JSONData) -> Void) {
        let task = session.dataTask(with: request2) { data, response, error in
        
            guard response != nil else {
                print("error")
               let error =  NSError.init(domain: Error.domain[0], code: Error.code[0], userInfo: Error.userInfo[0])
                 completion((nil, nil, error))
                return
            }
             let response = response as! HTTPURLResponse
            
            switch response.statusCode {
            case 200..<300: break
            case 300..<400:
                let error =  NSError.init(domain: Error.domain[1], code: Error.code[1], userInfo: Error.userInfo[1])
                completion((nil,response, error))
                return
            case 400..<500:
                let error =  NSError.init(domain: Error.domain[2], code: Error.code[2], userInfo: Error.userInfo[2])
                completion((nil,response, error))
                return
            default:
                let error =  NSError.init(domain: Error.domain[3], code: Error.code[3], userInfo: Error.userInfo[3])
                completion((nil,response, error))
                return
            }
            
            if data != nil {
            
                 let rawData = try! JSONSerialization.jsonObject(with: data!, options: [])
                completion((rawData as AnyObject?, response, nil))
            }
        }
    task.resume()}
    


    func convertDataToObjects(request: URLRequest, completion: @escaping (AnyObject?) -> Void) {
        grabData(request2: request) { JSONData in
            
            
            guard JSONData.2 == nil else{
                
                completion(JSONData.2)
                return
            }
            
            
            guard let results = JSONData.0 as? [String: AnyObject] else {
                return
            }
            
            if let resultDict = results["results"] {
                print(resultDict)
               completion(resultDict as! NSArray)
            } else {
                
                completion(results as AnyObject?)
            }
            
            
        }
}
    
    
}


class Request: Endpoint {
    internal var request: URLRequest

    var configuration: URLSessionConfiguration
    
     var queryItems: [URLQueryItem]?

     var path: String

     var baseURL = "http://swapi.co"

    var components: NSURLComponents
    
    var session: URLSession
    
    
    

   
    init(path: String) {
        self.path = path
        self.components = NSURLComponents.init(string: baseURL)!
        components.path = path
        self.configuration = URLSessionConfiguration.default
        self.session = URLSession.init(configuration: configuration)
        request = URLRequest.init(url: components.url!)
    }
    
    init?(url: URL) {
        self.path = ""
        self.components = NSURLComponents.init(string: baseURL)!
        components.path = path
        self.configuration = URLSessionConfiguration.default
        self.session = URLSession.init(configuration: configuration)
        request = URLRequest.init(url: url)
    }
    
}

































struct Error {
    static var domain = ["Server was unreachable", "Server has been moved or modified", "Bad Request", "Unkown Error"]
    static var code = [0, 1, 2, 3]
    static var userInfo = [[NSLocalizedDescriptionKey: "Please Try Again"], [NSLocalizedDescriptionKey: "Please Try A Different Link"], [NSLocalizedDescriptionKey: "Bad Request Made"], [NSLocalizedDescriptionKey: "Unkown"]]
}
