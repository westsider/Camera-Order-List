//
//  Equipment Classes.swift
//  Camera Order List
//
//  Created by Warren Hansen on 11/30/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

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

class Maker {
    var makerCamera: MakerCamera
    var makerPrimes: MakerPrimes
    var makerMacros: MakerMacros
    var makerProbes: MakerProbe
    
    init(makerCamera: MakerCamera, makerPrimes: MakerPrimes, makerMacros: MakerMacros, makerProbes: MakerProbe ) {
        self.makerCamera = makerCamera
        self.makerPrimes = makerPrimes
        self.makerMacros = makerMacros
        self.makerProbes = makerProbes
    }
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
    }
}

func setMacrosModel(maker: MakerMacros) -> [String] {
    switch maker {
    case .arri:
        return ["Macro"]
    case .zeiss:
        return ["Master Primes"]
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
    }
}

// add btn is pressed - get picker state and pass that into this func
//  when comp 1 = row 1, comp 2 = row 0, comp 3 = 0
//  what i need to get looks like nil, 1, 0, 0
//  find picker state
//  funcSetPrimesKit((comp2: 1, equip: e1) -  this will populate the lensTableview to "Zeiss", "Master Primes", "12mm, 18mm, 21mm, 35mm, 40mm, 50mm" ect
func setPrimesKit(compState: Array<Int>)-> String {
    // Zeiss Prime Section
    var primes = "I dont know what this is"
    // primes "Zeiss" "Master Primes"
    if compState[1] == 1 && compState[2] == 0 && compState[3] == 0 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss, ZMP"
    }
    
    // primes "Zeiss" "ultra Primes"
    if compState[1] == 1 && compState[2] == 0 && compState[3] == 1 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss, ZUP"
    }
    
    // primes "Zeiss" "super speeds"
    if compState[1] == 1 && compState[2] == 0 && compState[3] == 2 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss, ZSS"
    }
    
    // Leica Prime Section
    // primes "Leica" "Summilux-C"
    if compState[1] == 1 && compState[2] == 1 && compState[3] == 0 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Summilux-C"
    }
    
    // primes "Leica" "Summicron-C"
    if compState[1] == 1 && compState[2] == 1 && compState[3] == 1 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Summicron-C"
    }
    
    // primes "Leica" "Telephoto"
    if compState[1] == 1 && compState[2] == 1 && compState[3] == 2 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Telephoto"
    }
    
    // Canon Prime Section
    // primes "canon" "K-35"
    if compState[1] == 1 && compState[2] == 2 && compState[3] == 0 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Canon, K-35"
    }
    
    // primes "Canon" "Telephoto"
    if compState[1] == 1 && compState[2] == 2 && compState[3] == 1 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Canon, Telephoto"
    }
    
    // Cooke Prime Section
    // primes "Cooke" "i5"
    if compState[1] == 1 && compState[2] == 3 && compState[3] == 0 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, i5"
    }
    
    // primes "Cooke" "S4"
    if compState[1] == 1 && compState[2] == 3 && compState[3] == 1 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, S4"
    }
    
    // primes "Cooke" "Speed Panchro"
    if compState[1] == 1 && compState[2] == 3 && compState[3] == 2 {
        primes = "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, Speed Panchro"
    }
    
    return primes
}

func setPickerArray(component: Int, row: Int, lastCatagory: Int ) -> [[String]]  {
    
    var equipmentArray:[[String]] = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .arri)]
    
    if component < 3 {
        switch component {
            
        case 1: // change Catagory and maker populates
            switch row {
            case 0:
                equipmentArray = [Quantity, Catagory.allValues, MakerCamera.allValues,setCamModel(maker: .arri)] // cam
            case 1:
                equipmentArray = [Quantity, Catagory.allValues, MakerPrimes.allValues,setPrimesModel(maker: .zeiss)] // prime
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
            
        case 3:  //  change Model -- this logic not needed because wheel 1 and 2 populate compoment 3
            break
            
        default:
            break
        }
    }
    return equipmentArray
}


func setTableViewIcon(catagory: Int)-> UIImage {
    
    var thisImage:UIImage
    
    switch catagory {
    case 0: //  .camera:
        thisImage = UIImage(named: "cameraIcon")!
    case 1: //  .primes:
        thisImage = UIImage(named: "lensIcon")!
    case 2: //  .macros:
        thisImage = UIImage(named: "lensIcon")!
    case 3: //  .probeLens:
        thisImage = UIImage(named: "lensIcon")!
    case 4: //  .zoomLens:
        thisImage = UIImage(named: "lensIcon")!
    case 5: //  .aks:
        thisImage = UIImage(named: "gearIcon")!
    case 6: //  .finder:
        thisImage = UIImage(named: "gearIcon")!
    case 7: //  .filters:
        thisImage = UIImage(named: "gearIcon")!
    case 8: //  .support:
        thisImage = UIImage(named: "gearIcon")!
    default:
        thisImage = UIImage(named: "manIcon")!
    }
    return thisImage
}

class User {
    var name: String
    var production: String
    var company: String
    var city: String
    var date: String
    var weather: String
    var icon: UIImage
    //var logo: NSData
    init(name: String, production: String, company: String, city: String, date: String, weather: String, icon: UIImage) {
        self.name = name
        self.production = production
        self.company = company
        self.city = city
        self.date = date
        self.weather = weather
        self.icon = icon
    }
}

class Event {
    var eventName: String = "Default"
    var user: User
    var equipment = [[String]]()
    var images = [UIImage]()
    
    init(eventName: String, user: User, equipment: [[String]], images: [UIImage]){
        self.eventName = eventName
        self.user = user
        self.equipment = equipment
        self.images = images
    }
    
    //  Append the equipment array inside the event class
    func addEquipment(comp2: Int, equip: [String]){
        // replace the constructed array
        if equipment[0].isEmpty {
            equipment.removeAll(keepingCapacity: true)
            equipment.append(equip)
            self.images.append(setTableViewIcon(catagory: comp2))
        } else {
            self.equipment.append(equip)
            self.images.append(setTableViewIcon(catagory: comp2))
        }
    }
    
    func setTableViewIcon(catagory: Int)-> UIImage {
        
        var thisImage:UIImage
        
        switch catagory {
        case 0: //  .camera:
            thisImage = UIImage(named: "cameraIcon")!
        case 1: //  .primes:
            thisImage = UIImage(named: "lensIcon")!
        case 2: //  .macros:
            thisImage = UIImage(named: "lensIcon")!
        case 3: //  .probeLens:
            thisImage = UIImage(named: "lensIcon")!
        case 4: //  .zoomLens:
            thisImage = UIImage(named: "lensIcon")!
        case 5: //  .aks:
            thisImage = UIImage(named: "gearIcon")!
        case 6: //  .finder:
            thisImage = UIImage(named: "gearIcon")!
        case 7: //  .filters:
            thisImage = UIImage(named: "gearIcon")!
        case 8: //  .support:
            thisImage = UIImage(named: "gearIcon")!
        default:
            thisImage = UIImage(named: "manIcon")!
        }
        return thisImage
    }
    
    func populateTableview (catagory: Int)-> [[String]] {
        
        var titleArray = [String]()
        
        var detailArray = [String]()
        
        var imageArray = [UIImage]()
        
        // Add user
        titleArray.append("\(user.name) Director of Photography")
        
        detailArray.append("Camera Order \(user.production) \(user.date)")
        
        imageArray.append( UIImage(named: "manIcon")!)
        
        if equipment[0].isEmpty {
            print("Equipment is empty")
            equipment.removeAll(keepingCapacity: true)
            equipment.append( ["1a", "Camera", "Arri", "Alexa"])
            print(equipment)
        }
        
        var counter = 0
        // looping equipment[] assigning title and detail for the TableViewArray
        while counter < equipment.count {
            
            // camera || zoom logic -- if counter == 0 just user in array, dont add equip
            if  counter > 0 && ( equipment[counter][1] == "Camera" || equipment[counter][1] == "Zoom Lens" ) {
                titleArray.append("\(equipment[counter][0]) \(equipment[counter][1])")
                detailArray.append("\(equipment[counter][2]) \(equipment[counter][3])")
            }
            
            // primes || aks || filters || support || probe logic
            if  counter > 0  && ( equipment[counter][1] == "Primes" || equipment[counter][1] == "Macros" || equipment[counter][1] == "AKS"  || equipment[counter][1] == "Filters" || equipment[counter][1] == "Support" || equipment[counter][1] == "Probe Lens" )
            {
                titleArray.append("\(equipment[counter][0]) \(equipment[counter][1]) \(equipment[counter][2]) \(equipment[counter][3])")
                detailArray.append("Lenses Go Here")
            }
            
            counter += 1
        }
        return [titleArray, detailArray]
    }
    
    func printMessage(dualArrays: [[String]])-> String {
        var counter = 0
        var messageString = ""
        
        while counter < dualArrays[0].count {
            for element in dualArrays {
                messageString  += element[counter] + "\n"
            }
            counter += 1
            messageString  += "\n"
        }
        print("mail:\n\(messageString)")
        return messageString
    }
    
    func tableViewSize(tableViewArray: [[String]])-> Int {
        // safely check tableView Size
        if tableViewArray.count > 0 {
            return tableViewArray[0].count
        } else{
            return tableViewArray.count
        }
    }
}



