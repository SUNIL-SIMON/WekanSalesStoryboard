//
//  Constants.swift
//  Sales
//
//  Created by Sunil Simon on 17/10/23.
//

import Foundation

public class URLConstants {
    
    public static var baseURL = "https://ap-south-1.aws.data.mongodb-api.com/"
    public static var loginandfetchDataURL = "\(URLConstants.baseURL)app/devicesync-xkltu/endpoint/data/v1/action/find"
}

public class KeyChainConstants {
    public static let RealmEncrytionKey = "com.simon.ios.realmdbencryption"
    public static let tokenKey = "com.simon.ios.sharedKeychain.token"
    public static let accountKey = "com.simon.ios.sharedKeychain.account"
    
}

public class StringConstants { //WELL THESE WILL BE MOVED TO LOCALIZATION FILES
    public static let EmailLabel = "Email"
    public static let GenderLabel = "Gender"
    public static let AgeLabel = "Age"
    public static let SatisfactionLabel = "Satisfaction"
    public static let SaleLabel = "Sale"
    public static let StoreLabel = "Store"
    public static let CouponLabel = "Coupon"
    public static let PurchaseLabel = "Purchase"
    
}
