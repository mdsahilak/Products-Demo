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
    @Published var userFilter = Filter()
    
    var sections: [String] {
        var sections: [String] = []
        
        // apply filters (if any)
        let filteredProducts = getFilteredProducts()
        
        for product in filteredProducts {
            if !sections.contains(product.productName) {
                sections.append(product.productName)
            }
        }
        
        return sections
    }
    
    func getProductsFor(section: String) -> [Product] {
        let filteredProducts = getFilteredProducts()
        
        let productsForSection = filteredProducts.filter { $0.productName == section }
        return productsForSection
    }
    
    // Async function to get the data from the API
    func fetchData() async {
        guard let url = URL(string: "https://assessment-edvora.herokuapp.com") else { print("Invalid URL"); return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
            products = decodedProducts
            
        } catch {
            print("Unable to fetch Data due to ERROR: \(error)")
        }
    }
    
}
