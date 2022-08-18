//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Guligena Aierken on 8/17/22.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var toolBar: UIToolbar!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatePicker()
        configureToolBar()
    }
    
    private func configureDatePicker(){
        let action = UIAction { [ weak self ]_ in
            if let self = self {
                self.item.dateCreated = self.datePicker.date
            }
        }
        datePicker.addAction(action, for: .valueChanged)
    }
    
    private func configureToolBar() {
        let cameraAction = UIAction(title: "Camera", image: UIImage(systemName: "Camera")) { _ in
            print("Present camera")
        }
        
        let photoLibraryAction = UIAction(title: "Phote Library", image: UIImage(systemName: "photo.on.rectangle")) { _ in
            print("Present photo library")
        }
        
        let menu = UIMenu(children: [ cameraAction, photoLibraryAction ])
        
        let cameraItem = UIBarButtonItem(systemItem: .camera, menu: menu)
        toolBar.items = [cameraItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item.name
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        serialField.text = item.serialNumber
        datePicker.date = item.dateCreated
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
