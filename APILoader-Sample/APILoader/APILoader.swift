import Foundation

public let AL = APILoader.shared

open class APILoader {
    static let shared = APILoader()
    
    public func requestGET(_ url:String,headers:[HTTPHeader]? = nil, compleation:@escaping (Result<Data,APIError>) -> Void){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        if headers != nil {
            request = setHeader(request: request, header: headers!)
        }
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                compleation(.failure(.invalid(reason: error?.localizedDescription ?? "ERROR")))
            }
                
            if let response = response as? HTTPURLResponse {
               
                //成功のstatusでなければ
                if !(200...299).contains(response.statusCode) {
                    let reason = self.errorHandling(response: response)
                    compleation(.failure(.invalid(reason: reason )))
                }
            }
                
            
            guard let data = data else {
                return
            }

            compleation(.success(data))
            
           
        }
        task.resume()
    }
    
   
    
    public func requestPOST(_ url:String,headers:[HTTPHeader]? = nil,parameters:Parameters? = nil ,compleation:@escaping (Result<Data,APIError>)-> Void){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "POST"
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options:.prettyPrinted)
            }
            catch { print(error) }
        }
        
        if headers != nil {
            request = setHeader(request: request, header: headers!)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if error != nil {
                compleation(.failure(.invalid(reason: error?.localizedDescription ?? "ERROR")))
            }
                
            if let response = response as? HTTPURLResponse {
               
                //成功のstatusでなければエラーを返す
                if !(200...299).contains(response.statusCode) {
                    let reason = self.errorHandling(response: response)
                    compleation(.failure(.invalid(reason: reason )))
                }
            }
            compleation(.success(data))
        }
        task.resume()
    }
    
    public func requestPUT(_ url:String,headers:[HTTPHeader]? = nil,parameters:Parameters? = nil ,compleation:@escaping (Result<Data,APIError>)-> Void){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "PUT"
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options:.prettyPrinted)
            }
            catch { print(error) }
        }
        
        if headers != nil {
            request = setHeader(request: request, header: headers!)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if error != nil {
                compleation(.failure(.invalid(reason: error?.localizedDescription ?? "ERROR")))
            }
                
            if let response = response as? HTTPURLResponse {
               
                //成功のstatusでなければ
                if !(200...299).contains(response.statusCode) {
                    let reason = self.errorHandling(response: response)
                    compleation(.failure(.invalid(reason: reason )))
                }
            }
            compleation(.success(data))
        }
        task.resume()
    }
    
    public func requestDELETE(_ url:String,headers:[HTTPHeader]? = nil,parameters:Parameters? = nil ,compleation:@escaping (Result<Data,APIError>)-> Void){
        guard let URL = URL(string: url) else { return }
        var request = URLRequest(url: URL)
        request.httpMethod = "DELETE"
        
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options:.prettyPrinted)
            }
            catch { print(error) }
        }
        
        if headers != nil {
            request = setHeader(request: request, header: headers!)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if error != nil {
                compleation(.failure(.invalid(reason: error?.localizedDescription ?? "ERROR")))
            }
                
            if let response = response as? HTTPURLResponse {
               
                //成功のstatusでなければ
                if !(200...299).contains(response.statusCode) {
                    let reason = self.errorHandling(response: response)
                    compleation(.failure(.invalid(reason: reason )))
                }
            }
            compleation(.success(data))

        }
        task.resume()
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
    
    private func errorHandling(response:HTTPURLResponse)-> String {
        let message = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
        return "[\(response.statusCode)] \(message)"
    }
}
