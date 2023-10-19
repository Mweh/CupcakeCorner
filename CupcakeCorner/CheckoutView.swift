//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var showingAlert = false
    @State private var messageAlert = ""
    @State private var isFailedCheckout = false
    @State private var messageFailedCheckout = ""
    
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
                    Task{
                        await placeOrder()
                    }
                })
                .padding()
            }
        }
        .alert("Done!", isPresented: $showingAlert){
        } message: {
            Text(messageAlert)
        }
        .alert("Checkout failed", isPresented: $isFailedCheckout){
        } message: {
            Text(messageFailedCheckout)
        }
    }
    
    func placeOrder() async {
        // Convert our current order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encoded the order")
            return
        }
        
        // Tell Swift how to send that data over a network call.
        // GET = read/receive, POST = write/sent to the internet server
        let url = URL(string: "https://reqres.in/api/cupcakecorner")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
        
        // Run that request and process the response.
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            messageAlert = "Your \(decodedOrder.amount)x \(Order.flavors[decodedOrder.flavor].lowercased()) cupcake is on the way!"
            showingAlert = true
        } catch {
            isFailedCheckout = true
            messageFailedCheckout = "Check your connection and try again"
            print("Checkout failed")
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
