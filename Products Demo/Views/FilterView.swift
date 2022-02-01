//
//  FilterView.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 01/02/22.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var contentVM: ContentViewModel
    
    var body: some View {
        VStack {
            Text("Filter")
                .font(.title3)
                .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Products")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Divider()
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(names, id: \.self) { name in
                            Button {
                                contentVM.userFilter.toggleProductName(name)
                            } label: {
                                Text(name)
                                    .font(.headline)
                                    .padding().padding(.leading)
                                    .foregroundColor(contentVM.userFilter.name.contains(name) ? .blue : .black)
                            }
                            
                        }
                    }
                    
                    Text("State")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Divider()
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(states, id: \.self) { state in
                            Button {
                                contentVM.userFilter.toggleState(state)
                            } label: {
                                Text(state)
                                    .font(.headline)
                                    .padding().padding(.leading)
                                    .foregroundColor(contentVM.userFilter.states.contains(state) ? .blue : .black)
                            }

                        }
                    }
                    
                    Text("City")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Divider()
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(cities, id: \.self) { city in
                            Button {
                                contentVM.userFilter.toggleCity(city)
                            } label: {
                                Text(city)
                                    .font(.headline)
                                    .padding().padding(.leading)
                                    .foregroundColor(contentVM.userFilter.cities.contains(city) ? .blue : .black)
                            }

                        }
                    }
                }
            }
            
        }
        .background {
            Color(uiColor: .darkGray)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    private var names: [String] {
        let allProductNames = Set(contentVM.products.map { $0.productName })
        
        return allProductNames.sorted()
    }
    
    private var states: [String] {
        if contentVM.userFilter.name.isEmpty {
            let allStates = Set(contentVM.products.map { $0.address.state })
            
            return allStates.sorted()
        } else {
            let productsSelectedWithName = contentVM.products.filter { contentVM.userFilter.name.contains($0.productName) }
            let statesFromSelectedNames = Set(productsSelectedWithName.map { $0.address.state } )
            
            return statesFromSelectedNames.sorted()
        }
    }
    
    private var cities: [String] {
        if contentVM.userFilter.name.isEmpty {
            if contentVM.userFilter.states.isEmpty {
                let allCities = Set(contentVM.products.map { $0.address.city })
                
                return allCities.sorted()
            } else {
                let productsSelectedWithState = contentVM.products.filter { contentVM.userFilter.states.contains($0.address.state) }
                let citiesFromSelectedStates = Set(productsSelectedWithState.map { $0.address.city } )
                
                return citiesFromSelectedStates.sorted()
            }
            
        } else {
            let productsSelectedWithName = contentVM.products.filter { contentVM.userFilter.name.contains($0.productName) }
            
            if contentVM.userFilter.states.isEmpty {
                let allCitiesForSelectedNames = Set(productsSelectedWithName.map { $0.address.city } )
                
                return allCitiesForSelectedNames.sorted()
            } else {
                let productsSelectedWithNameAndState = productsSelectedWithName.filter { contentVM.userFilter.states.contains($0.address.state) }
                let citiesFromSelectedNamesAndStates = Set(productsSelectedWithNameAndState.map { $0.address.city } )
                
                return citiesFromSelectedNamesAndStates.sorted()
            }
        }
        
    }
    
}
