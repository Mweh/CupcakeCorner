//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var sharedOrder: SharedOrder
    
    var body: some View {
        Form{
            Section{
                TextField("Full name", text: $sharedOrder.order.addressName)
                TextField("Street address", text: $sharedOrder.order.addressStreet)
                TextField("City", text: $sharedOrder.order.addressCity)
                TextField("Zip code", text: $sharedOrder.order.addressZip)
            }
            Section{
                if sharedOrder.order.hasNoSpacedAddress == false {
                    Text("* Please remove unnecessary white space")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            Section{
                NavigationLink{
                    CheckoutView(sharedOrder: sharedOrder)
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
        sharedOrder.order.hasValidAddress == false || sharedOrder.order.hasNoSpacedAddress == false
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(sharedOrder: SharedOrder())
        }
    }
}
