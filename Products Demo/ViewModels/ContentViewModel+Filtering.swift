//
//  ContentViewModel+Filtering.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 02/02/22.
//

import SwiftUI

extension ContentViewModel {
    // Get the Product Items with Filter Applied
    func getFilteredProducts() -> [Product] {
        var filteredProducts: [Product] = products
        
        // Filter out names
        if !userFilter.names.isEmpty {
            filteredProducts = filteredProducts.filter({ product in
                userFilter.names.contains(product.productName)
            })
        }
        
        // Filter out states
        if !userFilter.states.isEmpty {
            filteredProducts = filteredProducts.filter({ product in
                userFilter.states.contains(product.address.state)
            })
        }
        
        // Filter out cities
        if !userFilter.cities.isEmpty {
            filteredProducts = filteredProducts.filter({ product in
                userFilter.cities.contains(product.address.city)
            })
        }
        
        return filteredProducts
    }
    
    // Toggling the Name Filter in FilterView
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

    // Toggling the State Filter in FilterView
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
    
    // Toggling the City Filter in FilterView
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
    
    // Clear Filters
    func clearFilters() {
        withAnimation(.spring()) {
            userFilter.clear()
        }
    }
}
