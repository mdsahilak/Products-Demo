//
//  Filter.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 01/02/22.
//

import Foundation
import SwiftUI

struct Filter {
    var name: Set<String> = []
    var states: Set<String> = []
    var cities: Set<String> = []
    
    // Helpers
    mutating func toggleProductName(_ productName: String) {
        if name.contains(productName) {
            name.remove(productName)
        } else {
            name.insert(productName)
        }
        
        // Reset Dependent Filters
        states = []
        cities = []
    }
    
    mutating func toggleState(_ state: String) {
        if states.contains(state) {
            states.remove(state)
        } else {
            states.insert(state)
        }
        
        // Reset Dependent Filters
        cities = []
    }
    
    mutating func toggleCity(_ city: String) {
        if cities.contains(city) {
            cities.remove(city)
        } else {
            cities.insert(city)
        }
    }
}
