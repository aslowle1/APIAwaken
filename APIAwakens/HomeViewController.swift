//
//  HomeViewController.swift
//  APIAwakens
//
//  Created by Andros Slowley on 1/29/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var characterButton: UIButton! { didSet { characterButton.setImage(#imageLiteral(resourceName: "icon-characters"), for: .normal);
    }}
    
    @IBOutlet weak var vehicleButton: UIButton! { didSet { vehicleButton.setImage(#imageLiteral(resourceName: "icon-vehicles-2"), for: .normal)}}

    
    @IBOutlet weak var starShipButton: UIButton! { didSet { starShipButton.setImage(#imageLiteral(resourceName: "icon-starships"), for: .normal)}}

    
    
       var characters = [SWCharacters]()
    var charactersSupplementalVehicle = [SWTransportation?]()
    
    var vehicles = [SWTransportation]()
    var starShips = [SWTransportation]() 

    var pathRequest: Request? //(path: "/api/people/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
view.backgroundColor = UIColor.black
        
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        
        for index in ["Characters","Vehicle","StarShips"] {
           
            switch index {
            case "Characters": pathRequest = Request.init(path: "/api/people/")
            case "Vehicle": pathRequest = Request.init(path: "/api/vehicles/")
            case "StarShips": pathRequest = Request.init(path: "/api/starships/")
            default: break
            }
            
            pathRequest?.convertDataToObjects(request: (pathRequest?.request)!){ results in
                DispatchQueue.main.async {
                    
                    switch results {
                    case is NSError: print("error")
                    case is NSArray: let results = results as! NSArray;
                    for result in results {
                        
                        let result = result as! [String: AnyObject]
                        switch index {
                        case "Characters": let object = try! SWCharacters.init(data: result )
                        self.characters.append(object!)
                        case "Vehicle": let object = try! SWTransportation.init(data: result )
                        self.vehicles.append(object!)
                        case "StarShips": let object = try! SWTransportation.init(data: result )
                        self.starShips.append(object!)
                        default: break
                        }
                        
                        }
                    default: print("none")
                    }
                    
                    print(self.characters.map() {$0.vehicles})
                }
            
        }
        
        
        }
    
    
    }


    @IBAction func buttonSelection(_ sender: UIButton) {
    
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "character" {
            print("Running")
           let destination =  segue.destination as! DetailedTableViewController
            
            destination.characters = characters
            destination.names = characters.map() { $0.name}
            destination.tableCategories = SWCharacters.parametersPerson
            destination.convertableTableCategories = SWCharacters.variableParameters
            
        } else {
            let destination =  segue.destination as! DetailedTableViewController
            destination.tableCategories = SWTransportation.parameters
            destination.convertableTableCategories = SWTransportation.variableParameters
            
            switch segue.identifier! {
            case "starShip": destination.vehicles = starShips
            destination.names = starShips.map() { $0.name}

            case "vehicle": destination.vehicles = vehicles
            destination.names = vehicles.map() { $0.name}
                
            let length = vehicles.map() { Int($0.length) }
            print(length)
                
            default: break
            }
            
            
        }
    }


}
