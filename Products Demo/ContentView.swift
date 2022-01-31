//
//  ContentView.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 31/01/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentVM = ContentViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edvora")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
            
            HStack(alignment: .bottom, spacing: 7) {
                Button {
                    
                } label: {
                    Text("Filters")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Clear")
                }
            }
            .padding([.bottom, .horizontal])
            
            Divider().background(Color.white)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 7) {
                    ForEach(contentVM.sections, id: \.self) { section in
                        Text(section)
                            .font(.title)
                            .padding()
                        
                        Divider().background(Color.white)
                        
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack(alignment: .center, spacing: 7) {
                                ForEach(contentVM.getProductsFor(section: section)) { product in
                                    ProductCardView(product: product)
                                        .padding()
                                }
                            }
                        }
                    }
                }
            }
            .task {
                await contentVM.fetchData()
            }
        }
        .foregroundColor(.white)
        .background(
            Color(uiColor: .darkGray)
        )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
