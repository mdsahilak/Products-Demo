//
//  ProductCardView.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 31/01/22.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            
            return formatter
        }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                AsyncImage(url: URL(string: product.imageURL)) { image in
                    image.resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                } placeholder: {
                    ProgressView().tint(.white)
                }
                .frame(width: 75, height: 75)
                .padding()
                
                VStack(alignment: .leading, spacing: 7) {
                    Text(product.productName)
                        .font(.title3)
                    Text(product.brandName)
                        .font(.body)
                    Text("$\(product.price)")
                        .font(.headline)
                }
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("\(product.address.city),")
                        .font(.caption)
                    Text(product.address.state)
                        .font(.callout)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(product.displayTime)
                        .font(.caption)
                    Text(product.displayDate)
                        .font(.callout)
                }
            }

            Text(product.description)
                .font(.footnote)
        }
        .padding()
        .frame(width: 300, height: 250, alignment: .center)
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 11)
                .foregroundColor(.black)
        )
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: Product(productName: "Product Name", brandName: "Brand Name", price: 100, address: Product.Address(state: "Karnataka", city: "Bangalore"), description: "Sample Product Item for testing.", date: "2014-10-29T13:38:20.447Z", time: "2020-03-16T01:24:10.478Z", imageURL: "https://www.pngall.com/wp-content/uploads/2016/05/Phone-Download-PNG.png"))
    }
}
