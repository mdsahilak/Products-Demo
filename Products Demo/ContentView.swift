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
        ScrollView {
            ForEach(contentVM.products) { product in
                ProductCardView(product: product)
            }
        }
        .task {
            await contentVM.fetchData()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
