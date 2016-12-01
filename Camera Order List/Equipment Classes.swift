//
//  Equipment Classes.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import Foundation
// Set up objects for camera order from what I learned at Udacity
//  create un mutable types of equipment objects
enum Catagory {
    case camera, primes, macros, probeLens, zoomLens, aks, finder, filters, support
    
    static let allValues = ["Camera", "Primes", "Macros", "Probe Lens", "Zoom Lens", "AKS", "Finder", "Filters", "Support"]
}

enum Maker {
    case arri, red, phantom, panavision, sony
}

enum Model {
    case alexa, alexaXT, red, phantom, dragon
}

//  create a mutable equipment order object
class Equipment {
    var quantity: Int       //  1
    var catagory: Catagory          //  Camera       Prime, Macro, Probe, Zoom
    var maker: Maker        //  Arri         Zeiss
    var model: Model        //  Alexa XT     Master Prime
    var kit: Array<String> = Array()   //  Nil          12mm, 14mm, 16mm ect
    
    init(quantity: Int, catagory: Catagory, maker: Maker, model: Model, kit: Array<String>) {
        self.quantity = quantity
        self.catagory = catagory
        self.maker = maker
        self.model = model
        self.kit = kit
    }
}

class User {
    var name: String
    var production: String
    var company: String
    var city: String
    var date: String
    var weather: String
    //var logo: NSData
    init(name: String, production: String, company: String, city: String, date: String, weather: String) {
        self.name = name
        self.production = production
        self.company = company
        self.city = city
        self.date = date
        self.weather = weather
    }
}

class Event {
    var user: User
    var equipment: Equipment
    
    init(user: User, equipment: Equipment){
        self.user = user
        self.equipment = equipment
    }
}
