//
//  SalesItemListCell.swift
//  Sales
//
//  Created by Sunil Simon on 14/10/23.
//

import Foundation
import UIKit
public class SalesItemListCell: UITableViewCell {
    @IBOutlet var itemNameLabel : UILabel!
    @IBOutlet var itemQuantityLabel : UILabel!
    @IBOutlet var itemPriceLabel : UILabel!
    
    func updateDetails(item  : Item?)
    {
        guard item != nil else {
            resetDetails()
            return
        }
        itemNameLabel.text = item!.name
        itemQuantityLabel.text = "\(item!.quantity)"
        itemPriceLabel.text = "\(item!.price)"
    }
    func resetDetails()
    {
        itemNameLabel.text = ""
        itemQuantityLabel.text = ""
        itemPriceLabel.text = ""
    }
}
