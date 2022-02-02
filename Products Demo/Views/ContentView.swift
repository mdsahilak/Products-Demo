//
//  ContentView.swift
//  Products Demo
//
//  Created by Muhammed Sahil Arayakandy on 31/01/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentVM = ContentViewModel()
    @State private var showFilterPopover = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Edvora")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
            
            HStack(alignment: .bottom, spacing: 7) {
                Button {
                    showFilterPopover.toggle()
                } label: {
                    HStack {
                        Text("Filters")
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.gray)
                            .padding(.leading)
                    }
                        .padding(.horizontal, 7)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .foregroundColor(.black)
                        )
                }
                
                Spacer()
                
                Button {
                    contentVM.clearFilters()
                } label: {
                    Text("Clear Filters")
                        .padding(.horizontal, 7)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 7)
                                .foregroundColor(.black)
                        )
                }
            }
            .padding([.bottom, .horizontal])
            .popover(isPresented: $showFilterPopover) {
                FilterView(contentVM: contentVM)
            }
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 7) {
                    ForEach(contentVM.sections, id: \.self) { section in
                        Text(section)
                            .font(.title)
                            .padding()
                        
                        Divider().background(Color.white).padding(.leading)
                        
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
                .edgesIgnoringSafeArea(.all)
        )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
