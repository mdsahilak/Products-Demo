//
//  FilterView.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 01/02/22.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var contentVM: ContentViewModel
    
    @State private var showProducts = false
    @State private var showStates = false
    @State private var showCities = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Filters")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            .padding([.top, .horizontal])
            
            Divider().background(Color.white)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 5) {
                    
                    Button {
                        withAnimation(.spring()) {
                            showProducts.toggle()
                        }
                    } label: {
                        headingButtonLabel(heading: "Products", showItems: showProducts)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        if showProducts {
                            ForEach(names, id: \.self) { name in
                                Button {
                                    contentVM.toggleNameFilter(name)
                                } label: {
                                    ItemButtonLabel(title: name, selected: contentVM.userFilter.names.contains(name))
                                }
                                .padding(.horizontal)
                                .padding(.leading)
                            }
                        }
                    }
                    
                    Button {
                        withAnimation(.spring()) {
                            showStates.toggle()
                        }
                    } label: {
                        headingButtonLabel(heading: "State", showItems: showStates)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        if showStates {
                            ForEach(states, id: \.self) { state in
                                Button {
                                    contentVM.toggleStateFilter(state)
                                } label: {
                                    ItemButtonLabel(title: state, selected: contentVM.userFilter.states.contains(state))
                                }
                                .padding(.horizontal)
                                .padding(.leading)
                            }
                        }
                    }
                    
                    Button {
                        withAnimation(.spring()) {
                            showCities.toggle()
                        }
                    } label: {
                        headingButtonLabel(heading: "City", showItems: showCities)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        if showCities {
                            ForEach(cities, id: \.self) { city in
                                Button {
                                    contentVM.toggleCityFilter(city)
                                } label: {
                                    ItemButtonLabel(title: city, selected: contentVM.userFilter.cities.contains(city))
                                }
                                .padding(.horizontal)
                                .padding(.leading)
                            }
                        }
                    }
                }
                
                clearFiltersButton()
                    .padding()
                
            }
            
        }
        .background {
            Color(uiColor: .darkGray)
                .edgesIgnoringSafeArea(.all)
        }
        
    }
    
    private func headingButtonLabel(heading: String, showItems: Bool) -> some View {
        HStack {
            Text(heading)
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "arrowtriangle.down.fill")
                .rotationEffect(showItems ? .zero : .degrees(90))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .foregroundColor(.black)
        )
    }
    
    private func ItemButtonLabel(title: String, selected: Bool) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(selected ? .green : .white)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 7)
                .foregroundColor(.black)
        )
    }
    
    private func clearFiltersButton() -> some View {
        Button {
            contentVM.clearFilters()
        } label: {
            HStack {
                Text("Clear Filters")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .foregroundColor(.black)
            )
        }
        .disabled(contentVM.userFilter.isCleared)
        .opacity(contentVM.userFilter.isCleared ? 0.7 : 1)

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
