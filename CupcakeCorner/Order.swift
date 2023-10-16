//
//  Order.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

class Order: ObservableObject{
    static let flavors = ["Chocolate", "Vanilla", "Strawberry", "Banana"]
    
    @Published var flavor = 0
    @Published var amount = 1
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraSprinkle = false
                extraFrosted = false
            }
        }
    }
    @Published var extraSprinkle = false
    @Published var extraFrosted = false
    
    @Published var addressName = ""
    @Published var addressStreet = ""
    @Published var addressCity = ""
    @Published var addressZip = ""

    var hasValidAddress: Bool{
        if addressName.isEmpty || addressStreet.isEmpty || addressCity.isEmpty || addressZip.isEmpty{
            return false
        }
        return true
    }
    
    var cost: Double{
        // There’s a base cost of $2 per cupcake.
        var cost = Double(amount) * 8_000
        
        // We’ll add a little to the cost for more complicated cakes.
        cost += (Double(flavor) * 2_000)
        
        // Adding sprinkles will be another 50 cents per cake.
        if extraSprinkle{
            cost += (Double(amount) * 1_000)
        }
        
        // Extra frosting will cost $1 per cake.
        if extraFrosted{
            cost += (Double(amount) * 2_000)
        }
        
        return cost
    }
}
