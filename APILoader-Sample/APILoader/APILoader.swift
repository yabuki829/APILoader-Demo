//
//  APILoader.swift
//  APILoader-Sample
//
//  Created by 薮木翔大 on 2022/11/15.
//

import Foundation




open class APILoader {
    static let shared = APILoader()
    
    func requestGET(_ url:String,headers:[HTTPHeader]? = nil, compleation:@escaping (Data) -> Void){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        if headers != nil {
            request = setHeader(request: request, header: headers!)
        }
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            compleation(data)
           
        }
        task.resume()
    }
    
   
    
    func requestPOST(_ url:String,headers:[HTTPHeader]? = nil,parameters:Parameters? = nil ,compleation:@escaping (Data)-> Void){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        if parameters != nil {
            do { request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options:[]) }
            catch { print(error) }
        }
        
        if headers != nil {
            request = setHeader(request: request, header: headers!)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            compleation(data)
        }
        task.resume()
    }
    
    func requestPUT(_ url:String){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
    }
    
    func requestDELETE(_ url:String){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "DELETE"
    }
}


extension APILoader {
    private func setHeader(request:URLRequest,header:[HTTPHeader]) -> URLRequest{
        var request = request
        for i in 0..<header.count {
            request.setValue(header[i].value, forHTTPHeaderField: header[i].name)
        }
        return request
    }
    
    
    private func setQuery(){}
}
