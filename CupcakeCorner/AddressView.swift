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
                if order.hasNoSpacedAddress == false {
                    Text("* Please remove unnecessary white space")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                } label: {
                    Text("Checkout")
                }
                .disabled(hasValidAddress())
                // 1. Challenge
                // Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
                
            }
        }
        .navigationTitle("Address details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func hasValidAddress() -> Bool{
        order.hasValidAddress == false || order.hasNoSpacedAddress == false
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
        }
    }
}
