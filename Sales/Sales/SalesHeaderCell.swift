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
        customerEmailLabel.text = "Email : \(document!.customer.email)"
        customerGenderLabel.text = "Gender : \(document!.customer.gender)"
        customerAgeLabel.text = "Age : \(document!.customer.age)"
        customerSatisfactionLabel.text = "Satisfaction : \(document!.customer.satisfaction)"
        customerDateLabel.text = "Sale : \(document!.saleDate.getDate()?.getDate() ?? "")"
        customerStoreLabel.text = "Store : \(document!.storeLocation)"
        customerCouponLabel.text = "Coupon : \(document!.couponUsed)"
        customerPurchaseLabel.text = "Purchase : \(document!.purchaseMethod)"
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
