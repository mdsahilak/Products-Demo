//
//  ContentViewModel.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 31/01/22.
//

import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    var sections: [String] {
        var sections: [String] = []
        
        for product in products {
            if !sections.contains(product.productName) {
                sections.append(product.productName)
            }
        }
        
        return sections
    }
    
    func getProductsFor(section: String) -> [Product] {
        let productsForSection = products.filter { $0.productName == section }
        return productsForSection
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://assessment-edvora.herokuapp.com") else { print("Invalid URL"); return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
            products = decodedProducts
            
        } catch {
            print(error)
        }
    }
}
