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
    
    func getFilteredProducts() -> [Product] {
        var filteredProducts: [Product] = products
        
        if !userFilter.names.isEmpty {
            filteredProducts = filteredProducts.filter({ product in
                userFilter.names.contains(product.productName)
            })
        }
        
        if !userFilter.states.isEmpty {
            filteredProducts = filteredProducts.filter({ product in
                userFilter.states.contains(product.address.state)
            })
        }
        
        if !userFilter.cities.isEmpty {
            filteredProducts = filteredProducts.filter({ product in
                userFilter.cities.contains(product.address.city)
            })
        }
        
        return filteredProducts
    }
    
    func clearFilters() {
        userFilter.names = []
        userFilter.states = []
        userFilter.cities = []
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
    
    func toggleNameFilter(_ name: String) {
        // Add or Remove based on the situation
        if userFilter.names.contains(name) {
            userFilter.names.remove(name)
        } else {
            userFilter.names.insert(name)
        }
        
        // Reset the dependant filters --
        // Get the product objects
        let productsForSelectedNames = products.filter { userFilter.names.contains($0.productName) }
        
        // Get the states that are allowed
        let statesForSelectedNames = Set(productsForSelectedNames.map { $0.address.state } )
        // Remove any state that is not allowed
        userFilter.states = userFilter.states.filter { statesForSelectedNames.contains($0) }
        
        // Get the cities that are allowed
        let citiesForSelectedNames = Set(productsForSelectedNames.map { $0.address.city } )
        // Remove any city that is not allowed
        userFilter.cities = userFilter.cities.filter { citiesForSelectedNames.contains($0) }
    }

    func toggleStateFilter(_ state: String) {
        // Add or Remove based on the situation
        if userFilter.states.contains(state) {
            userFilter.states.remove(state)
        } else {
            userFilter.states.insert(state)
        }
        
        // Reset the dependant filters --
        // Get the cities that are allowed
        let productsForSelectedStates = products.filter { userFilter.states.contains($0.address.state) }
        let citiesForSelectedStates = Set(productsForSelectedStates.map { $0.address.city } )
        
        // remove any city that is not allowed
        userFilter.cities = userFilter.cities.filter { citiesForSelectedStates.contains($0) }
    }

    func toggleCityFilter(_ city: String) {
        // Add or Remove based on the situation
        if userFilter.cities.contains(city) {
            userFilter.cities.remove(city)
        } else {
            userFilter.cities.insert(city)
        }
        
        // No dependent filters --
        // Lowest level filter, so there are no dependent filters
    }
}
