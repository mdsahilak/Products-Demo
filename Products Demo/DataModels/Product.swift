//
//  Product.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 31/01/22.
//

import Foundation

struct Product: Codable, Identifiable {
    var id: UUID = UUID()
    
    let productName: String
    let brandName: String
    let price: Int
    let address: Address
    let description: String
    let date: String
    let time: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case brandName = "brand_name"
        
        case price
        case address
        case description = "discription" // Spelling Error in the API JSON Data
        case date
        case time
        
        case imageURL = "image"
    }
    
    struct Address: Codable {
        let state: String
        let city: String
    }
}
