//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://img.kurio.network/F6I9fpIbiJl7nOd2MWK6t8ue4t4=/440x440/filters:quality(80)/https://kurio-img.kurioapps.com/20/10/02/938f6bba-c6d1-4cbb-84ab-ac8cf620cfaa.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 400)
                
                Text("Your total is \(order.cost, format: .currency(code: "IDR"))")
                    .font(.title)
                Button("Place order", action: {
                    test()
                })
                .padding()
            }
        }
    }
    
    func test(){
        print("flavor: \(order.flavor)")
        print("amount: \(order.amount)")
        print("extraSprinkle: \(order.extraSprinkle)")
        print("extraFrosted: \(order.extraFrosted)")
        print("Total cost: \(order.cost)")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
