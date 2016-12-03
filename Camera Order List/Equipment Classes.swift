//
//  Equipment Classes.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import Foundation
let Quantity = ["1","2","3","4","5","6","7","8","9"]

enum Catagory {
    case camera, primes, macros, probeLens, zoomLens, aks, finder, filters, support
    
    static let allValues = ["Camera", "Primes", "Macros", "Probe Lens", "Zoom Lens", "AKS", "Finder", "Filters", "Support"]
}

enum MakerCamera {
    case arri, red, phantom, panavision, sony
    
    static let allValues = ["Arri", "Red", "Phantom", "Panavision", "Sony"]
}

enum MakerPrimes {
    case zeiss, leica, canon, cooke
    
    static let allValues = ["Zeiss", "Leica", "Canon", "Cooke"]
}

enum MakerMacros {
    case arri, zeiss
    
    static let allValues = ["Arri", "Zeiss"]
}

enum MakerProbe {
    case innovision, tRex, revolution, skater, century, optex
    
    static let allValues = ["Innovision", "T-Rex", "Revolution", "Skater", "Century", "Optex"]
}

func setCamModel(maker: MakerCamera) -> [String] {
    switch maker {
    case .arri:
        return ["Alexa", "Mini", "Amira"]
    case .red:
        return ["Dragon", "Weapon", "Epic"]
    case .phantom:
        return ["Flex 4k", "Flex", "HD Gold"]
    case .panavision:
        return ["Genesis", "Platinium", "Millenioum"]
    default:
        return  ["set cam model", "failed", "break"]
    }
}

func setPrimesModel(maker: MakerPrimes) -> [String] {
    switch maker {
    case .zeiss:
        return ["Master Primes", "Ultra Primes", "Super Speeds"]
    case .leica:
        return ["Summilux-C", "Summicron-C", "Telephoto"]
    case .canon:
        return ["K-35", "Telephoto"]
    case .cooke:
        return ["i5", "S4", "Speed Panchro"]
    //default:
      //  return  ["set prime model", "failed", "break"]
    }
}

func setMacrosModel(maker: MakerMacros) -> [String] {
    switch maker {
    case .arri:
        return ["Macro"]
    case .zeiss:
        return ["Master Primes"]
    //default:
      //  return  ["set prime model", "failed", "break"]
    }
}

func setProbeModel(maker: MakerProbe) -> [String] {
    switch maker {
    case .innovision:
        return ["Probe II+"]
    case .tRex:
        return ["Probe"]
    case .revolution:
        return ["Probe"]
    case .skater:
        return ["Scope"]
    case .century:
        return ["Periscope"]
    case .optex:
        return ["Excellence"]
    //default:
      //  return  ["set probe model", "failed", "break"]
    }
}

//class PickerData {
//    
//    var equipmentArray:[[String]] = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .arri)]
//    
//    init(equipmentArray: [[String]]) {
//        self.equipmentArray = equipmentArray
//    }

//  a function to inperpret the picker
//  then return equipmentArray[Quantity 1, Catagory: Camera, Maker: Arri, Model: Alexa ]

// what if you create the array in the VC then modify it in the func?

//  then pass equipmentArray[] to tableview
//  and then pass and array of equipmentArray[] to the Event
//  then email the event and store it persistently
//  this func works great till I get to wheel 4, then it re installs the default camera arri alexa

    func setPickerArray(component: Int, row: Int, lastCatagory: Int ) -> [[String]]  {
        
        var equipmentArray:[[String]] = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .arri)]
        
        if component < 3 {
            switch component {
                //  case 0 is loaded on first run in VC
                
            case 1: // change Catagory and maker populates
                switch row {
                case 0:
                    equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues,setCamModel(maker: .arri)] // cam
                case 1:
                    equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues,setPrimesModel(maker: .zeiss)] // priome
                case 2:
                    equipmentArray = [Quantity, Catagory.allValues, MakerMacros.allValues, setMacrosModel(maker: .arri)] // macro
                case 3:
                    equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .innovision)] // probe, zoom, aks,
                default:
                    equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues,["Array ","out ", "of ", "index"]]
                }
                
            case 2:  //  Based on Catagory change maker - model populates
                switch lastCatagory {
                case 0:     //  prevCatagory = Camera and Maker = Arri
                    switch row {
                    case 0:
                        equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .arri)]
                    case 1: //  prevCatagory = Camera and Maker = Red
                        equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .red)]
                    case 2: //  prevCatagory = Camera and Maker = Phantom
                        equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .phantom)]
                    case 3: //  prevCatagory = Camera and Maker = Panavision
                        equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .panavision)]
                    default:
                        equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 1:     //  prevCatagory = Primes and Maker = Zeiss
                    switch row {
                    case 0:
                        equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .zeiss)]
                    case 1: //  prevCatagory = Primes and Maker = leics
                        equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .leica)]
                    case 2: //  prevCatagory = Primes and Maker = cannon
                        equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .canon)]
                    case 3: //  prevCatagory = Primes and Maker = cooke
                        equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .cooke)]
                    default:
                        equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 2:     //  prevCatagory = Macros and Maker = Arri || Zeiss
                    switch row {
                    case 0:
                        equipmentArray = [Quantity, Catagory.allValues, MakerMacros.allValues, setMacrosModel(maker: .arri)]
                    case 1: //  prevCatagory = Macros and Maker = Zeiss
                        equipmentArray = [Quantity, Catagory.allValues, MakerMacros.allValues, setMacrosModel(maker: .zeiss)]
                    default:
                        equipmentArray = [Quantity, Catagory.allValues, MakerMacros.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 3:     //  prevCatagory = ProbeLens and Maker = Innovision || T-Rex || Revolution || Skater
                    switch row {
                    case 0:
                        equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .innovision)]
                    case 1: //  prevCatagory = ProbeLens and Maker = T-Rex
                        equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .tRex)]
                    case 2: //  prevCatagory = ProbeLens and Maker = Revolution
                        equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .revolution)]
                    case 3: //  prevCatagory = ProbeLens and Maker = Skater
                        equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .skater)]
                    default:
                        equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, ["Array ","out ", "of ", "index"]]
                    }
                default:
                    break
                }
                
                
            case 3:  //  change Model -- this logic not needed because wheel 1 and 2 populate wheel 3
                break
                //        switch row {
                //        case 0:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .innovision)]
                //        case 1:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .tRex)]
                //        case 2:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .revolution)]
                //        case 3:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .skater)]
                //        case 4:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .century)]
                //        case 5:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .optex)]
                //        default:
                //            equipmentArray = [Quantity, Catagory.allValues, MakerProbe.allValues, ["Array ","out ", "of ", "index"]]
            //        }
            default:
                break
            }
            }
        return equipmentArray
        
    }
//}


// Set up objects for camera order from what I learned at Udacity
//  create un mutable types of equipment objects

//let Quantity = ["1","2","3","4","5","6","7","8","9"]
//
//enum Catagory {
//    case camera, primes, macros, probeLens, zoomLens, aks, finder, filters, support
//    
//    static let allValues = ["Camera", "Primes", "Macros", "Probe Lens", "Zoom Lens", "AKS", "Finder", "Filters", "Support"]
//}
//
//enum Maker {
//    case arri, red, phantom, panavision, sony
//    
//    static let allValues = ["Arri", "Red", "Phantom", "Panavision", "Sony"]
//}
//
//enum Model {
//    case alexa, alexaXT, red, phantom, dragon
//}
//
////  create a mutable equipment order object
//class Equipment {
//    var quantity: Int       //  1
//    var catagory: Catagory          //  Camera       Prime, Macro, Probe, Zoom
//    var maker: Maker        //  Arri         Zeiss
//    var model: Model        //  Alexa XT     Master Prime
//    var kit: Array<String> = Array()   //  Nil          12mm, 14mm, 16mm ect
//    
//    init(quantity: Int, catagory: Catagory, maker: Maker, model: Model, kit: Array<String>) {
//        self.quantity = quantity
//        self.catagory = catagory
//        self.maker = maker
//        self.model = model
//        self.kit = kit
//    }
//}
//
//class User {
//    var name: String
//    var production: String
//    var company: String
//    var city: String
//    var date: String
//    var weather: String
//    //var logo: NSData
//    init(name: String, production: String, company: String, city: String, date: String, weather: String) {
//        self.name = name
//        self.production = production
//        self.company = company
//        self.city = city
//        self.date = date
//        self.weather = weather
//    }
//}
//
//class Event {
//    var user: User
//    var equipment: Equipment
//    
//    init(user: User, equipment: Equipment){
//        self.user = user
//        self.equipment = equipment
//    }
//}
