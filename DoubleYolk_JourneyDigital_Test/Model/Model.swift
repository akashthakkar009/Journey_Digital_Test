//
//  Model.swift
//  DoubleYolk_JourneyDigital_Test
//
//  Created by DoubleYolk on 03/12/21.
//

import Foundation


/// Post : Model
struct Post: Decodable {
    let userId:Int
    let id: Int
    let title: String
    let body: String
}

/// Comments : Model
struct Comments: Decodable {
    
    let id : Int
    let postId : Int
    let name: String
    let email: String
    let body: String
}
