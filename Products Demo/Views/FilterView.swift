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
                                contentVM.toggleNameFilter(name)
                            } label: {
                                Text(name)
                                    .font(.headline)
                                    .padding().padding(.leading)
                                    .foregroundColor(contentVM.userFilter.names.contains(name) ? .blue : .black)
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
                                contentVM.toggleStateFilter(state)
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
                                contentVM.toggleCityFilter(city)
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
    
    // Names for the Product Section
    private var names: [String] {
        let allProductNames = Set(contentVM.products.map { $0.productName })
        
        return allProductNames.sorted()
    }
    
    // States for the State Section
    private var states: [String] {
        if contentVM.userFilter.names.isEmpty {
            let allStates = Set(contentVM.products.map { $0.address.state })
            
            return allStates.sorted()
        } else {
            let productsSelectedWithName = contentVM.products.filter { contentVM.userFilter.names.contains($0.productName) }
            let statesFromSelectedNames = Set(productsSelectedWithName.map { $0.address.state } )
            
            return statesFromSelectedNames.sorted()
        }
    }
    
    // Cities for the City Section
    private var cities: [String] {
        if contentVM.userFilter.names.isEmpty {
            if contentVM.userFilter.states.isEmpty {
                let allCities = Set(contentVM.products.map { $0.address.city })
                
                return allCities.sorted()
            } else {
                let productsSelectedWithState = contentVM.products.filter { contentVM.userFilter.states.contains($0.address.state) }
                let citiesFromSelectedStates = Set(productsSelectedWithState.map { $0.address.city } )
                
                return citiesFromSelectedStates.sorted()
            }
            
        } else {
            let productsSelectedWithName = contentVM.products.filter { contentVM.userFilter.names.contains($0.productName) }
            
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
