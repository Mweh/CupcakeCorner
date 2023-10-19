//
//  Order.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

class Order: ObservableObject, Codable{
    
    enum Codingkeys: CodingKey {
        case flavor, amount, extraSprinkle, extraFrosted, addressName, addressStreet, addressCity, addressZip
    }
    
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
        let isAddressEmpty = addressName.isEmpty || addressStreet.isEmpty || addressCity.isEmpty || addressZip.isEmpty
        
        if isAddressEmpty {
            return false
        }
        return true
    }
    
    var hasNoSpacedAddress: Bool{
        let isAddressWhiteSpaced = addressName.hasSuffix(" ") || addressStreet.hasSuffix(" ") || addressCity.hasSuffix(" ") || addressZip.hasSuffix(" ")
        
        if isAddressWhiteSpaced {
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
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Codingkeys.self)
        
        try container.encode(flavor, forKey: .flavor)
        try container.encode(amount, forKey: .amount)
        
        try container.encode(extraSprinkle, forKey: .extraSprinkle)
        try container.encode(extraFrosted, forKey: .extraFrosted)
        
        try container.encode(addressName, forKey: .addressName)
        try container.encode(addressStreet, forKey: .addressCity)
        try container.encode(addressCity, forKey: .addressCity)
        try container.encode(addressZip, forKey: .addressZip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        
        flavor = try container.decode(Int.self, forKey: .flavor)
        amount = try container.decode(Int.self, forKey: .amount)
        
        extraSprinkle = try container.decode(Bool.self, forKey: .extraSprinkle)
        extraFrosted = try container.decode(Bool.self, forKey: .extraFrosted)
        
        addressName = try container.decode(String.self, forKey: .addressName)
        addressStreet = try container.decode(String.self, forKey: .addressCity)
        addressCity = try container.decode(String.self, forKey: .addressCity)
        addressZip = try container.decode(String.self, forKey: .addressZip)

    }
    
}
