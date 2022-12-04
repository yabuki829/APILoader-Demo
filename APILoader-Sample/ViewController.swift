//
//  ViewController.swift
//  APILoader-Sample
//
//  Created by 薮木翔大 on 2022/11/15.
//

import UIKit
import EasyLayout


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
class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
  

    

    let tableView = UITableView()
    var data = [Job]()
    var url = "http://127.0.0.1:8000/api/job/"
    override func viewDidLoad() {
        super.viewDidLoad()
//        let url = "https://fakestoreapi.com/products"

        post(url: url, title: "メルカリ", company:"メルカリ", location: "東京")
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.constraints(top: view.topAnchor, paddingTop: 0,
                              left: view.leftAnchor, paddingLeft: 0,
                              right: view.rightAnchor, paddingRight: 0,
                              bottom: view.bottomAnchor, paddingBottom: 0)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delete(url:url, id: indexPath.row )
        
    }


}


extension ViewController{
    func get(url:String){
        AL.requestGET(url) { result in
            switch result {
            case .success(let data):
                print("Success")
                do {
                    let objects = try JSONDecoder().decode([Job].self, from: data)
                    print(1,objects)
                    self.data = objects
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                
                }
            case .failure(let error):
                print("取得エラー",error)
               
            }
            
        }
        
    }
    
    func post(url:String,title:String,company:String,location:String){
        let headers = [HTTPHeader(name: "content-type", value: "application/json")]
        let body:Parameters = [
                    "title":title,
                    "company":company,
                    "location":location
        ]
       
        AL.requestPOST(url,headers: headers,parameters: body) { result in
            
            
            switch result {
            case .success(let data):
                do {
                    let objects = try JSONDecoder().decode([Job].self, from: data)
                    self.data = objects
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print("エラー1",error)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func delete(url:String,id:Int){
        let headers = [HTTPHeader(name: "content-type", value: "application/json")]
        AL.requestDELETE(url,headers: headers) { result in
            
            switch result {
            case .success(let data):
                do {
                  
                    
                    let aa = try JSONSerialization.jsonObject(with: data, options: [])
                    print(aa)
                    print("削除完了")
                } catch {
                    print("エラー削除",error)
                }
            case .failure(let error):
                print(error)
            }
           
        }
    }
}
