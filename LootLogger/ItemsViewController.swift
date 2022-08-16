//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Guligena Aierken on 8/16/22.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(String(describing: item.valueInDollars))"
        
        return cell
    }
}
