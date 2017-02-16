//
//  PeopleVehiclesShips.swift
//  APIAwakens
//
//  Created by Andros Slowley on 1/30/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import Foundation
protocol StarWars {

}

protocol People: StarWars {
    var name: String { get }
    var birthYear: String { get }
    var gender: String { get }
    var height: String { get }      //Could mkae this a comupted property
    var eyeColor: String { get }
    var homeWorld: String { get }
    var vehicles: [String] { get }
    var starShips: [String] { get }
    
    func heightConversion(height: Double) -> Double
}

protocol Transportation: StarWars {
    var name: String { get }
    var model: String { get }
    var vehicleClass: String { get }
    var cost: String { get }     //Could mkae this a comupted property
    var length: String { get }    //Could mkae this a comupted property
    var crew: String { get }

    var pilots: [String] { get }
    

    func costConversion(cost: Double) -> Double
    func lengthConversion(length: Double) -> Double
    
    }

class SWCharacters: People {

    var name: String
    var birthYear: String
    var gender: String
    var height: String       //Could mkae this a comupted property
    var eyeColor: String
    var homeWorld: String
    var vehicles: [String]
    var starShips: [String]
    
    init?(data: [String: AnyObject]) throws {
        self.name = data["name"] as! String
        self.birthYear = data["birth_year"] as! String
        self.gender = data["gender"] as! String
        self.height = data["height"] as! String       //Could mkae this a comupted property
        self.eyeColor = data["eye_color"] as! String
        self.homeWorld = data["homeworld"] as! String
        self.vehicles = data["vehicles"] as! [String]
        self.starShips = data["starships"]  as! [String]
    }
    
        
    static let parametersPerson = ["Name", "Born", "Gender", "Eye Color"]
    
    static let variableParameters = ["Height"]
    
    internal func heightConversion(height: Double) -> Double {
        return 0.0
    }
}

    
    class SWTransportation: Transportation {
        var name: String
        var model: String
        var vehicleClass: String
        var cost: String       //Could mkae this a comupted property
        var crew: String
        var length: String
        
        var pilots: [String]
        
        
        init?(data: [String: AnyObject]) throws {
            self.name = data["name"] as! String
            self.model = data["model"] as! String
            self.vehicleClass = (data["vehicle_class"] ?? data["starship_class"]) as! String
            self.cost = data["cost_in_credits"] as! String       //Could mkae this a comupted property
            self.crew = data["crew"] as! String
            self.length = data["length"] as! String
            self.pilots = data["pilots"] as! [String] 
        }

        static let parameters = ["Name", "Model", "Crew"]
        static let variableParameters = ["Cost", "Length"]
        
        

        
        func costConversion(cost: Double) -> Double { return 0.0}
        func lengthConversion(length: Double) -> Double { return 0.0 }
        
        
        
    }
    
    
    
    

