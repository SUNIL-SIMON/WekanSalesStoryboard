//
//  LoginViewModel.swift
//  Sales
//
//  Created by Sunil Simon on 17/10/23.
//

import Foundation
class LoginViewModel{
    
    let requestHandler = URLRequestHandler.shared
    let dbHandler = DBHandler.shared
    var loginState : LoginState
    {
        didSet
        {
            loginStateChangedBindingNotifier()
            if loginState == .LOGGEDIN{
                let token = "***sometoken***"
                if let _ = KeychainService.loadKeyChainData(service: KeyChainConstants.tokenKey, account: KeyChainConstants.accountKey) {
                    KeychainService.updateKeyChainData(service: KeyChainConstants.tokenKey, account: KeyChainConstants.accountKey, data: token)
                }
                else{
                    KeychainService.saveKeyChainData(service: KeyChainConstants.tokenKey, account: KeyChainConstants.accountKey, data: token)
                }
            }
        }
    }
    var loginStateChangedBindingNotifier : (() -> ()) = {}
    
    init() {
        self.loginState = .NOTLOGGEDIN
    }
    
    func login(user : String, pwd : String)
    {
        self.loginState = .WAITING
        
        let urlString =  URLConstants.loginandfetchDataURL

        let parameterData : [String : Any] =
        [
            "dataSource": "Cluster0",
            "database": "sample_supplies",
            "collection": "sales"
        ]
        let jsonBody = try! JSONSerialization.data(withJSONObject: parameterData, options: .prettyPrinted)
        
        var request : URLRequest
        request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = HtttpMethod.POST.rawValue
        request.httpBody = jsonBody
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(user, forHTTPHeaderField: "email")
        request.addValue(pwd, forHTTPHeaderField: "password")

        self.requestHandler.sendRequest(type: Sales.self, request : request, completion: {[weak self] (sales,requestStatus)in
            DispatchQueue.main.async {
                switch(requestStatus)
                {
                case .SUCCESS:
                    self?.dbHandler.deleteDB(completion: { (_) in
                        if sales != nil{
                            self?.dbHandler.writeDB(items: sales!.documents, completion: { (_) in })
                        }
                    })
                    self?.loginState = .LOGGEDIN
                case .BADRESPONSE:
                    self?.loginState = .NOTLOGGEDIN
                case .BADREQUEST:
                    self?.loginState = .NOTLOGGEDIN
                case .DECODEFAILED:
                    self?.loginState = .NOTLOGGEDIN
                }
                
            }
        })
    }
    func chkLoginStatus()
    {
        self.loginState = .WAITING
        let user = KeychainService.getUserKeyChainCredentials(service: KeyChainConstants.tokenKey, account: KeyChainConstants.accountKey)
        if user != nil{
            self.loginState = .LOGGEDIN
            self.loginState = .NOTLOGGEDIN
        }
        else{
            self.loginState = .NOTLOGGEDIN
        }
    }
}
