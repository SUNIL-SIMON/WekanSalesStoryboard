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
