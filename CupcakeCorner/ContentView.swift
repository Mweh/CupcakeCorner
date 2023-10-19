//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var sharedOrder = SharedOrder()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Choose flavor", selection: $sharedOrder.order.flavor){
                        ForEach(Order.flavors.indices, id: \.self) {
                            Text(Order.flavors[$0])
                        }
                    }
                    Stepper("Amount of cupcake: \(sharedOrder.order.amount)", value: $sharedOrder.order.amount, in: 1...20)
                } header: {
                    Text("Order your cupcake")
                }
                
                Section{
                    Toggle("Addon", isOn: $sharedOrder.order.specialRequestEnabled.animation())
                    sharedOrder.order.specialRequestEnabled == true ? AnyView(specialRequestDisabled()) : AnyView(EmptyView())
                } header: {
                    Text("Want to add something?")
                }
                Section{
                    NavigationLink{
                        AddressView(sharedOrder: sharedOrder)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
    func specialRequestDisabled() -> some View{
        return Group{
            Toggle("Extra sprinkles", isOn: $sharedOrder.order.extraSprinkle)
            Toggle("Extra Frosted", isOn: $sharedOrder.order.extraFrosted)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
