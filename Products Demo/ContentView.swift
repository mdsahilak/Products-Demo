//
//  ContentView.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 31/01/22.
//

import SwiftUI

struct ContentView: View {
    @State private var products: [Product] = []
    
    var body: some View {
        List {
            ForEach(products) { product in
                VStack {
                    Text(product.productName)
                        .font(.title)

                    Text(product.description)
                        .font(.subheadline)
                }
            }
        }
        .task {
            await downloadData()
        }
    }
    
    func downloadData() async {
        guard let url = URL(string: "https://assessment-edvora.herokuapp.com") else { print("Invalid URL"); return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
            products = decodedProducts
            
        } catch let error {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
