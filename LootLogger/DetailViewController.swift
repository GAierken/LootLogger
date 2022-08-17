//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Guligena Aierken on 8/17/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        serialField.text = item.serialNumber
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
}
