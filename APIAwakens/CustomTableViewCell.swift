//
//  CustomTableViewCell.swift
//  APIAwakens
//
//  Created by Andros Slowley on 1/29/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var optionsSelector: UISegmentedControl!
    @IBOutlet weak var valueTitleLabel: UILabel!
    @IBOutlet weak var numericalValueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func changeTitle(_ sender: UISegmentedControl) {
        if Double(numericalValueLabel.text!) != nil {
        if optionsSelector.selectedSegmentIndex == 1 {
            
            if optionsSelector.titleForSegment(at: 1) == "English" {
            
                numericalValueLabel.text = String(Double(numericalValueLabel.text!)! + 50)}
            else { numericalValueLabel.text = String(Double(numericalValueLabel.text!)! + 100) }
            
        } else if optionsSelector.selectedSegmentIndex == 0 {
            
            if optionsSelector.titleForSegment(at: 0) == "Metric" {
            
            numericalValueLabel.text = String(Double(numericalValueLabel.text!)! - 50)
            } else { numericalValueLabel.text = String(Double(numericalValueLabel.text!)! - 100)}
        }
        }
    
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
