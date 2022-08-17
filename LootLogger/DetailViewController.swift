//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Guligena Aierken on 8/17/22.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
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
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text, let value =  numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
