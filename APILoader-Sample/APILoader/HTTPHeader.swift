//
//  HTTPHeader.swift
//  APILoader-Sample
//
//  Created by 薮木翔大 on 2022/11/15.
//

import Foundation

struct HTTPHeader {
    let name:String
    let value:String
     
    public init(name:String,value:String){
        self.name = name
        self.value = value
    }
}
