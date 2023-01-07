//
//  Networking.swift
//  Task 1
//
//  Created by Ogabek Matyakubov on 07/01/23.
//

import Foundation
import Alamofire

private let IS_TESTER = true
private let DEP_SER = "https://63b8fcd43329392049e96d86.mockapi.io/"
private let DEV_SER = "https://63b8fcd43329392049e96d86.mockapi.io/"

let headers: HTTPHeaders = [
    "Accept": "application/json",
]

class Network {
    
    // MARK : - AFHttp Requests
    
    class func get(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .get, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func post(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .post, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func put(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .put, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func del(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .delete, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    // MARK : - AFHttp Methods
    class func server(url: String) -> URL{
        if(IS_TESTER){
            return URL(string: DEV_SER + url)!
        }
        return URL(string: DEP_SER + url)!
    }
    
    // MARK : - AFHttp Apis
    static let API_CONTACT_LIST = "api/contacts"
    static let API_CONTACT_SINGLE = "api/contacts/" //id
    static let API_CONTACT_CREATE = "api/contacts"
    static let API_CONTACT_UPDATE = "api/contacts/" //id
    static let API_CONTACT_DELETE = "api/contacts/" //id
    
    
    // MARK : - AFHttp Params
    class func paramsEmpty() -> Parameters {
        let parameters: Parameters = [
            :]
        return parameters
    }
    
    class func paramsPostCreate(contact: Contact) -> Parameters {
        let parameters: Parameters = [
            "name": contact.name,
            "number": contact.number,
        ]
        return parameters
    }
    
    class func paramsPostUpdate(contact: Contact) -> Parameters {
        let parameters: Parameters = [
            "name": contact.name,
            "number": contact.number,
        ]
        return parameters
    }
    
}
