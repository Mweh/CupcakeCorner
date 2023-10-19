//
//  Order.swift
//  CupcakeCorner
//
//  Created by Muhammad Fahmi on 15/10/23.
//

import SwiftUI

class SharedOrder: ObservableObject{
    // 3. Challenge
    // For a more challenging task, see if you can convert our data model from a class to a struct, then create an ObservableObject class wrapper around it that gets passed around. This will result in your class having one @Published property, which is the data struct inside it, and should make supporting Codable on the struct much easier.
    
    @Published var order: Order
    
    init() {
        order = Order(flavor: 0, amount: 1, specialRequestEnabled: false, extraSprinkle: false, extraFrosted: false, addressName: "", addressStreet: "", addressCity: "", addressZip: "")
    }
}

struct Order: Codable{
    // structs have memberwise initializers by default while class need to do it manually
    
    //    enum Codingkeys: CodingKey {
    //        case flavor, amount, extraSprinkle, extraFrosted, addressName, addressStreet, addressCity, addressZip
    //    }
    
    static let flavors = ["Chocolate", "Vanilla", "Strawberry", "Banana"]
    
    var flavor = 0
    var amount = 1
    var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraSprinkle = false
                extraFrosted = false
            }
        }
    }
    var extraSprinkle = false
    var extraFrosted = false
    
    var addressName = ""
    var addressStreet = ""
    var addressCity = ""
    var addressZip = ""
    
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
    
    var hasNoSpacedAddress: Bool{
        let isAddressWhiteSpaced = addressName.hasSuffix(" ") || addressStreet.hasSuffix(" ") || addressCity.hasSuffix(" ") || addressZip.hasSuffix(" ")
        
        if isAddressWhiteSpaced {
            return false
        }
        return true
    }
    
    var hasValidAddress: Bool{
        let isAddressEmpty = addressName.isEmpty || addressStreet.isEmpty || addressCity.isEmpty || addressZip.isEmpty
        
        if isAddressEmpty {
            return false
        }
        return true
    }
    
    func imageFlavor(imageFlavors: Int) -> String {
        let imageChoco = "https://img.kurio.network/F6I9fpIbiJl7nOd2MWK6t8ue4t4=/440x440/filters:quality(80)/https://kurio-img.kurioapps.com/20/10/02/938f6bba-c6d1-4cbb-84ab-ac8cf620cfaa.jpg"
        let imageVanilla = "https://www.mybakingaddiction.com/wp-content/uploads/2011/07/unwrapped-vanilla-cupcake-hero.jpg"
        let imageStrawberry = "https://preppykitchen.com/wp-content/uploads/2022/07/Strawberry-Cupcakes-Feature.jpg"
        let imageBanana = "https://tornadoughalli.com/wp-content/uploads/2021/12/BANANA-CUPCAKES-4-1.jpg"
        let imageError = "https://www.dictio.id/uploads/db3342/original/3X/c/4/c45165360f01a3ceb96f8e44a1aef3ee29f7d404.jpeg"
        
        switch imageFlavors {
        case 0:
            return imageChoco
        case 1:
            return imageVanilla
        case 2:
            return imageStrawberry
        case 3:
            return imageBanana
        default:
            return imageError
        }
    }
}

// Below is the better version for validAddress bool
//    var hasValidAdddress : Bool {
//        // day 52 - challenge 1
//        if name.trimmingCharacters(in: .whitespaces).isEmpty ||
//            streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
//            city.trimmingCharacters(in: .whitespaces).isEmpty ||
//            zip.trimmingCharacters(in: .whitespaces).isEmpty {
//            return false
//        } else {
//            return true
//        }
//    }


//    This comment below is if it's only have one class conform to ObservableObject and Codable that required init

//        init() { }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Codingkeys.self)
//
//        try container.encode(flavor, forKey: .flavor)
//        try container.encode(amount, forKey: .amount)
//
//        try container.encode(extraSprinkle, forKey: .extraSprinkle)
//        try container.encode(extraFrosted, forKey: .extraFrosted)
//
//        try container.encode(addressName, forKey: .addressName)
//        try container.encode(addressStreet, forKey: .addressStreet)
//        try container.encode(addressCity, forKey: .addressCity)
//        try container.encode(addressZip, forKey: .addressZip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Codingkeys.self)
//
//        flavor = try container.decode(Int.self, forKey: .flavor)
//        amount = try container.decode(Int.self, forKey: .amount)
//
//        extraSprinkle = try container.decode(Bool.self, forKey: .extraSprinkle)
//        extraFrosted = try container.decode(Bool.self, forKey: .extraFrosted)
//
//        addressName = try container.decode(String.self, forKey: .addressName)
//        addressStreet = try container.decode(String.self, forKey: .addressStreet)
//        addressCity = try container.decode(String.self, forKey: .addressCity)
//        addressZip = try container.decode(String.self, forKey: .addressZip)
//    }

