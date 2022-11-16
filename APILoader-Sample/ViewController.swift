//
//  ViewController.swift
//  APILoader-Sample
//
//  Created by 薮木翔大 on 2022/11/15.
//

import UIKit

public let AL = APILoader.shared

struct Product:Decodable {
    let id:Int
    let title:String
    let description:String
}


struct Question:Codable{
    let id:String
    let questionText:String
}

struct Job: Codable {
    let id:Int
    let title:String
    let company:String
    let location:String
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = "https://fakestoreapi.com/products"
        let url = "http://127.0.0.1:8000/api/job/"
        post(url: url)
        get(url: url)
    }
    
    
    
    
    func get(url:String){
        AL.requestGET(url) { data in
            do {
                let objects = try JSONDecoder().decode([Job].self, from: data)
                print(objects)
            } catch {
                print("エラー",error)
            }
        }
    }
    
    func post(url:String){
        let body = ["title":"Software Engineer, iOS - Mercari",
                    "company":"Merucari",
                    "location":"Japan/Tokyo"] as! Parameters
        
        let headers = [HTTPHeader(name: "content-type", value: "application/json")]
        AL.requestPOST(url,headers: headers,parameters: body) { data in
            do {
                let objects = try JSONDecoder().decode([Job].self, from: data)
                print(objects)
            } catch {
                print("エラー",error)
            }
        }
    }

}
