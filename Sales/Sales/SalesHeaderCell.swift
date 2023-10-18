//
//  SalesHeaderCell.swift
//  Sales
//
//  Created by Sunil Simon on 14/10/23.
//

import Foundation
import UIKit
class SalesHeaderCell: UITableViewCell {


    @IBOutlet var customerEmailLabel : UILabel!
    @IBOutlet var customerGenderLabel : UILabel!
    @IBOutlet var customerAgeLabel : UILabel!
    @IBOutlet var customerSatisfactionLabel : UILabel!
    @IBOutlet var customerDateLabel : UILabel!
    @IBOutlet var customerStoreLabel : UILabel!
    @IBOutlet var customerCouponLabel : UILabel!
    @IBOutlet var customerPurchaseLabel : UILabel!
    
    func updateDetails(document  : Document?)
    {
        guard document != nil else {
            resetDetails()
            return
        }
        guard document!.customer != nil else {
            resetDetails()
            return
        }
        customerEmailLabel.text = "\(StringConstants.EmailLabel) : \(document!.customer.email)"
        customerGenderLabel.text = "\(StringConstants.GenderLabel) : \(document!.customer.gender)"
        customerAgeLabel.text = "\(StringConstants.AgeLabel) : \(document!.customer.age)"
        customerSatisfactionLabel.text = "\(StringConstants.SatisfactionLabel) : \(document!.customer.satisfaction)"
        customerDateLabel.text = "\(StringConstants.SaleLabel) : \(document!.saleDate.getDate()?.getDate() ?? "")"
        customerStoreLabel.text = "\(StringConstants.StoreLabel) : \(document!.storeLocation)"
        customerCouponLabel.text = "\(StringConstants.CouponLabel) : \(document!.couponUsed)"
        customerPurchaseLabel.text = "\(StringConstants.PurchaseLabel) : \(document!.purchaseMethod)"
    }
    func resetDetails()
    {
        customerEmailLabel.text = ""
        customerGenderLabel.text = ""
        customerAgeLabel.text = ""
        customerSatisfactionLabel.text = ""
        customerDateLabel.text = ""
        customerStoreLabel.text = ""
        customerCouponLabel.text = ""
        customerPurchaseLabel.text = ""
    }
    
}
