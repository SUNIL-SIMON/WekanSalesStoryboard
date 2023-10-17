//
//  SalesViewModel.swift
//  Sales
//
//  Created by Sunil Simon on 17/10/23.
//

import Foundation
public protocol SalesModelViewDelegate: AnyObject{
    func getSearcText()->String?
}
class SalesViewModel{
    
    public weak var salesModelViewDelegate : SalesModelViewDelegate?
    let requestHandler = URLRequestHandler.shared
    let dbHandler = DBHandler.shared
    var filteredSales  : Sales?
    {
        didSet
        {
            listModifiedBindingNotifier()
        }
    }
    var listModifiedBindingNotifier : (() -> ()) = {}
    var loginState : LoginState
    {
        didSet
        {
            loginStateChangedBindingNotifier()
        }
    }
    var loginStateChangedBindingNotifier : (() -> ()) = {}
    
    init() {
        loginState = .LOGGEDIN
        applyFilter()
    }
    func applyFilter()
    {
        let queue = DispatchQueue(label: "com.simon.ios.customqueue")
        queue.sync {

            let searchText = salesModelViewDelegate?.getSearcText()
            var sales = Sales(documents: nil)
            if searchText == nil || searchText == ""{
                let documents = dbHandler.readDB(type: Document.self)?.toList(type: Document.self)
                sales.documents = documents
            }
            else{
                let documents = dbHandler.readDB(type: Document.self)?.where{$0.customer.email.contains(searchText!, options: .caseInsensitive)}.toList(type: Document.self)
                sales.documents = documents
            }

            DispatchQueue.main.async {
                self.filteredSales = sales
            }
        }
    }
    func logMeOut()
    {
        self.dbHandler.deleteDB(completion: {[weak self] (_) in
            KeychainService.clearUserKeyChainCredentials(service: KeyChainConstants.tokenKey, account: KeyChainConstants.accountKey)
            self?.loginState = .NOTLOGGEDIN
        })
    }
}
