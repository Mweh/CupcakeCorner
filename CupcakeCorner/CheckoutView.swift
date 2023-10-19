//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var sharedOrder: SharedOrder
    
    @State private var showingAlert = false
    @State private var messageAlert = ""
    @State private var isFailedCheckout = false
    @State private var messageFailedCheckout = ""
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: sharedOrder.order.imageFlavor(imageFlavors: sharedOrder.order.flavor)), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 400)
                
                Text("Your total is \(sharedOrder.order.cost, format: .currency(code: "IDR"))")
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
        
        // 2. Challenge
        //        If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
        
        .alert("Checkout failed", isPresented: $isFailedCheckout){
        } message: {
            Text(messageFailedCheckout)
        }
    }
    
    func placeOrder() async {
        // Convert our current order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(sharedOrder.order) else {
            print("Failed to encoded the order")
            return
        }
        
        // Tell Swift how to send that data over a network call.
        // GET = read/receive, POST = write/sent to the internet server
        let url = URL(string: "https://reqres.in/api/cupcakecorner")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST" // you can test the network by toggle commented this
        
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
        print("flavor: \(sharedOrder.order.flavor)")
        print("amount: \(sharedOrder.order.amount)")
        print("extraSprinkle: \(sharedOrder.order.extraSprinkle)")
        print("extraFrosted: \(sharedOrder.order.extraFrosted)")
        print("Total cost: \(sharedOrder.order.cost)")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(sharedOrder: SharedOrder())
    }
}
