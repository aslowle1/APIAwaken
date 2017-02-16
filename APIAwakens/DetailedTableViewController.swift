//
//  DetailedTableViewController.swift
//  APIAwakens
//
//  Created by Andros Slowley on 1/29/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit

class DetailedTableViewController: UITableViewController {

    @IBOutlet weak var smallestBarItem: UIBarButtonItem!
    @IBOutlet weak var largestBarItem: UIBarButtonItem!
    @IBOutlet weak var smallestItemCalculated: UIBarButtonItem!
    @IBOutlet weak var largestItemClaculated: UIBarButtonItem!
   
    var characters: [SWCharacters]?
    var vehicles: [SWTransportation]?
    var starShips: [SWTransportation]?
    
    var names = [String]()
    
    

    var tableCategories = [String]()
    var displayInfoFor: [String]? {didSet { tableView.reloadData() }}
   
    var convertableTableCategories = ["Height"]
    var convertableTableCategoriesDetail: [String] = [] {didSet { tableView.reloadData() }}
    
    var additionalPageStarShip = [SWTransportation?]()
    var additionalPageStarVehicle = [SWTransportation?]()
    var additionalPagePilot = [SWCharacters?]()
    
    func updateTables() {

        if characters?.isEmpty == false {
        displayInfoFor = [(characters?[pickerOptions.selectedRow(inComponent: 0)].name)!,
                          (characters?[pickerOptions.selectedRow(inComponent: 0)].birthYear)!,
                          (characters?[pickerOptions.selectedRow(inComponent: 0)].gender)!,
                          (characters?[pickerOptions.selectedRow(inComponent: 0)].eyeColor)!]
   convertableTableCategoriesDetail = [(characters?[pickerOptions.selectedRow(inComponent: 0)].height)!]
        
        tableView.reloadData()
        }
        
        else if vehicles?.isEmpty == false {
            displayInfoFor = [(vehicles?[pickerOptions.selectedRow(inComponent: 0)].name)!,
                              (vehicles?[pickerOptions.selectedRow(inComponent: 0)].model)!,
                              (vehicles?[pickerOptions.selectedRow(inComponent: 0)].crew)!]
            convertableTableCategoriesDetail = [(vehicles?[pickerOptions.selectedRow(inComponent: 0)].cost)!,
            (vehicles?[pickerOptions.selectedRow(inComponent: 0)].length)!]
            
            tableView.reloadData()

        }
        
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pickerOptions: UIPickerView!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTables()
        tableView.reloadData()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
smallestBarItem.isEnabled = false
        largestBarItem.isEnabled = false
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        
        
        
      pickerOptions.dataSource = self
      pickerOptions.delegate = self

        updateAdditionalPages(locationInArray: 0)
        
        if characters?.isEmpty == false {
            var count = 0
            let height = characters!.map() { Int($0.height) }
            let sorted = height.sorted{ $0! < $1!}
            let shortest = sorted.first
            let tallest = sorted.last
            
            for index in height {
                if index == shortest!!{
                    smallestItemCalculated.title = characters?.map() { $0.name }[count]
                }
                
                if index == tallest!!{
                    largestItemClaculated.title = characters?.map() { $0.name }[count]
                }
                count += 1
            }
            
            nameLabel.text = (characters?[0].name)!
        } else if vehicles?.isEmpty == false{
            nameLabel.text = (vehicles?[0].name)!
 
            var count = 0
            var length = vehicles!.map() { Double($0.length) }
            
            
            for index in length {
                if index == nil{
                    length.remove(at: count)
                }
count += 1
            }
            
            
            count = 0
            let sorted = length.sorted{ $0! < $1!}
            let shortest = sorted.first
            let tallest = sorted.last
            
            for index in length {
                if index == shortest!!{
                    smallestItemCalculated.title = vehicles?.map() { $0.name }[count]
                }
                
                if index == tallest!!{
                    largestItemClaculated.title = vehicles?.map() { $0.name }[count]
                }
                count += 1
            }
            

            
 
            
            
        } else { nameLabel.text = (starShips?[0].name)!
        
        
            var count = 0
            let length = starShips!.map() { Double($0.length) }
            let sorted = length.sorted{ $0! < $1!}
            let shortest = sorted.first
            let tallest = sorted.last
            
            for index in length {
                if index == shortest!!{
                    smallestItemCalculated.title = starShips?.map() { $0.name }[count]
                }
                
                if index == tallest!!{
                    largestItemClaculated.title = starShips?.map() { $0.name }[count]
                }
                count += 1
            }
            
        
        
        
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
        
        return tableCategories.count
        } else if section == 1 { return convertableTableCategories.count }
        
        else { return (characters != nil) ? 2 : 1}
        
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 && indexPath.section == 2 {
            if  characters?.isEmpty == false && additionalPageStarVehicle[0] != nil {
             return true
            } else if (vehicles?.isEmpty == false || starShips?.isEmpty == false) && additionalPagePilot[0] != nil { return true }
            else {
                return false }
        } else if indexPath.section == 2 && indexPath.row == 1{
            
            print(additionalPageStarShip)
            if  characters?.isEmpty == false && additionalPageStarShip[0] != nil {
            return true
            } else { return false }
        
        }
    return true
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicInformationCell", for: indexPath)
        cell.textLabel?.text = tableCategories[indexPath.row]
            cell.detailTextLabel?.text = displayInfoFor?[indexPath.row]
       return cell
        }
        
        else if indexPath.section == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath) as!
        CustomTableViewCell

        cell.valueTitleLabel.text = convertableTableCategories[indexPath.row]
        cell.numericalValueLabel.text = convertableTableCategoriesDetail[indexPath.row]
            cell.optionsSelector.selectedSegmentIndex = 0
            if characters?.isEmpty == false {
        cell.optionsSelector.setTitle("English", forSegmentAt: 0)
                cell.optionsSelector.setTitle("Metric", forSegmentAt: 1) }
            else {
                
                if indexPath.row == 1 {cell.optionsSelector.setTitle("English", forSegmentAt: 0)
                    cell.optionsSelector.setTitle("Metric", forSegmentAt: 1)} else {
                
                cell.optionsSelector.setTitle("USD", forSegmentAt: 0)
                    cell.optionsSelector.setTitle("Credits", forSegmentAt: 1)}}
              return cell
            
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PageFollowUpCell", for: indexPath)
            
            if characters?.isEmpty == false {
                switch indexPath.row {
                case 0: cell.textLabel?.text = "Vehicles"
                case 1: cell.textLabel?.text = "StarShips"
                default: break
                }
            }
                else {
                cell.textLabel?.text = "Pilot"
            }
            
            return cell }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Page" {
            
            if let selection = tableView.indexPathForSelectedRow {
               let destination = segue.destination as! DetailedTableViewController
                if selection.section == 2 && selection.row == 0 {
                    

                    if characters?.isEmpty == false{
                    
                    destination.characters = nil
                    let newVech = additionalPageStarVehicle as![SWTransportation]
                    print(additionalPageStarVehicle)
                    
                    destination.vehicles = newVech
                    for index in newVech {
                        destination.names.append(index.name)
                    }
                    destination.tableCategories = SWTransportation.parameters
                    destination.convertableTableCategories = SWTransportation.variableParameters
                    } else if vehicles?.isEmpty == false || starShips?.isEmpty == false{
                        if additionalPagePilot[0] != nil {
                            let newPilot = additionalPagePilot.map() { $0!}
                        for index in newPilot {
                            destination.names.append((index.name))
                        }
                        
                        destination.characters = newPilot
                            destination.tableCategories = SWCharacters.parametersPerson
                            destination.convertableTableCategories = SWCharacters.variableParameters

                        }
                    }
                } else if selection.section == 2 && selection.row == 1 {
                    if characters?.isEmpty == false{
                        
                        destination.characters = nil
                        let newVech = additionalPageStarShip
                        
                        destination.vehicles = newVech.map() {$0!}
                        for index in newVech {
                            destination.names.append((index?.name)!)
                        }
                        destination.tableCategories = SWTransportation.parameters
                        destination.convertableTableCategories = SWTransportation.variableParameters
                    }
                }
            }
        }
    }
    
}





extension DetailedTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return names[row]
    }
 
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        
        if characters?.isEmpty == false {
        displayInfoFor = [(characters?[row].name)!,
                          (characters?[row].birthYear)!,
                          (characters?[row].gender)!,
                          (characters?[row].height)!,
                          (characters?[row].eyeColor)!,
                          (characters?[row].homeWorld)!]
        
        convertableTableCategoriesDetail = [(characters?[row].height)!]
        
        nameLabel.text = (characters?[row].name)!
            
            additionalPageStarVehicle = [SWTransportation?]()
            updateAdditionalPages(locationInArray: row)
        } else if vehicles?.isEmpty == false {
            displayInfoFor = [(vehicles?[row].name)!,
                              (vehicles?[row].model)!,
                              (vehicles?[row].crew)!]
            convertableTableCategoriesDetail = [(vehicles?[row].cost)!, (vehicles?[row].length)!]
            nameLabel.text = (vehicles?[row].name)!
            tableView.reloadData()
            additionalPagePilot = [SWCharacters?]()
            updateAdditionalPages(locationInArray: row)
        }
    }
    

    func updateAdditionalPages(locationInArray: Int) {
        var tempVehicles = [[String?]]()
        var tempPilots = [[String?]]()
        var tempStarShips = [[String?]]()
        if characters?.isEmpty == false {
            for temp in characters! {
                tempVehicles.append(temp.vehicles)
                tempStarShips.append(temp.starShips)
            }
            
            let index = tempVehicles[locationInArray]
    
                switch index.count {
                case nil, 0:
                additionalPageStarVehicle.insert(nil, at: 0)
                case 1:
                let url = index[0]
                    
                    let request = Request.init(url: URL.init(string: url!)!)
                    
                    request?.convertDataToObjects(request: (request?.request)!) { results in
                        
                        if let results = results as? [String: AnyObject] {
                            let final = try! SWTransportation.init(data: results)
                          
                           self.additionalPageStarVehicle.insert(final, at: 0)}
                        
                    };
                    
                default:
                
                for index2 in index{

                    let url = index2
                    let request = Request.init(url: URL.init(string: url!)!)
                    request?.convertDataToObjects(request: (request?.request)!) { results in
                        
                        if let results = results as? [String: AnyObject] {
                            let final = try! SWTransportation.init(data: results)
                            self.additionalPageStarVehicle.insert(final, at: 0)
                            
                            }
                    }
                }
                    }
            
            
            
            
            let range = tempStarShips[locationInArray]
            
            switch range.count {
            case nil, 0:
                additionalPageStarShip.insert(nil, at: 0)
            case 1:
                let url = range[0]
                
                let request = Request.init(url: URL.init(string: url!)!)
                
                request?.convertDataToObjects(request: (request?.request)!) { results in
                    
                    if let results = results as? [String: AnyObject] {
                        let final = try! SWTransportation.init(data: results)
                        
                        self.additionalPageStarShip.insert(final, at: 0)}
                    
                };
                
            default:
                
                for index2 in range{
                    
                    let url = index2
                    let request = Request.init(url: URL.init(string: url!)!)
                    request?.convertDataToObjects(request: (request?.request)!) { results in
                        
                        if let results = results as? [String: AnyObject] {
                            let final = try! SWTransportation.init(data: results)
                            self.additionalPageStarShip.insert(final, at: 0)
                            
                        }
                    }
                }
            }
            
        } else if vehicles?.isEmpty == false || starShips?.isEmpty == false {
            
            for temp in vehicles ?? starShips! {
                tempPilots.append(temp.pilots)
            }
            
            let index = tempPilots[locationInArray]
       
                switch index.count {
                case nil, 0:
                    additionalPagePilot.insert(nil, at: 0)
                case 1: let url = index[0]
                    
                    let request = Request.init(url: URL.init(string: url!)!)
                    
                    request?.convertDataToObjects(request: (request?.request)!) { results in
                        
                        if let results = results as? [String: AnyObject] {
                            let final = try! SWCharacters.init(data: results)
                     
                           self.additionalPagePilot.insert(final, at: 0)

                        }
                        
                    }
                    
                default:
                for index2 in index{
                    let url = index2
                    let request = Request.init(url: URL.init(string: url!)!)
                    request?.convertDataToObjects(request: (request?.request)!) { results in
                        
                        if let results = results as? [String: AnyObject] {
                            let final = try! SWCharacters.init(data: results)
                             self.additionalPagePilot.insert(final, at: 0)
                       
                        }
                    }
                    }
                }
            
            
        }

        
        
        
    }






}

extension String {
    mutating func removePrefix() -> String {
        let arrayString = self as NSString
        let range = NSRange.init(location: 0, length: 15)
        self = arrayString.replacingCharacters(in: range, with: "")
        return self
    }
}



