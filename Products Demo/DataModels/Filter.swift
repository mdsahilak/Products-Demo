//
//  Filter.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 01/02/22.
//

import Foundation
import SwiftUI

struct Filter {
    var names: Set<String> = []
    var states: Set<String> = []
    var cities: Set<String> = []
    
    var isCleared: Bool {
        names.isEmpty && states.isEmpty && cities.isEmpty
    }
    
    mutating func clear() {
        names = []
        states = []
        cities = []
    }
}
