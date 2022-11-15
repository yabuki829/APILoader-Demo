//
//  ViewController.swift
//  APILoader-Sample
//
//  Created by 薮木翔大 on 2022/11/15.
//

import UIKit

public let AL = APILoader.shared

struct Product:Codable {
    let id:Int
    let title:String
    let description:String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://fakestoreapi.com/products"
        AL.requestGET(url) { data in
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
            } catch {
                print("エラー",error)
            }
        }
        
      
        
        
    }


}

