//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Full name", text: $order.addressName)
                TextField("Street address", text: $order.addressStreet)
                TextField("City", text: $order.addressCity)
                TextField("Zip code", text: $order.addressZip)
            }
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Address details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
        }
    }
}
