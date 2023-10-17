//
//  SalesViewController.swift
//  Sales
//
//  Created by Sunil Simon on 17/10/23.
//

import Foundation
import UIKit
class SalesViewController: UIViewController{
    
    let salesViewModel = SalesViewModel()
    @IBOutlet var salesListView : UITableView!
    @IBOutlet var searchBar : UISearchBar!
    @IBOutlet var logOutButton : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        salesListView.delegate = self
        salesListView.dataSource = self
        searchBar.delegate = self
        salesViewModel.salesModelViewDelegate = self
        setUpObserver()
        
    }
    
    func setUpObserver()
    {
        self.salesViewModel.listModifiedBindingNotifier = { [weak self] in
            self?.salesListView.reloadData()
        }
        self.salesViewModel.loginStateChangedBindingNotifier = { [weak self] in
            if self?.salesViewModel.loginState == .NOTLOGGEDIN{
                self?.popSalesPage()
            }
        }
    }
    
    @IBAction func logOut()
    {
        self.salesViewModel.logMeOut()
    }
    
    func popSalesPage()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
extension SalesViewController : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salesViewModel.filteredSales?.documents?[section].items.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return salesViewModel.filteredSales?.documents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = salesListView.dequeueReusableCell(withIdentifier:  "SECTIONVIEW") as! SalesHeaderCell?
        if(headerView == nil)
        {
            headerView = SalesHeaderCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SECTIONVIEW")
        }
        headerView?.updateDetails(document : salesViewModel.filteredSales?.documents?[section])
        return headerView!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "DEFAULT") as! SalesItemListCell?
        if(cell == nil)
        {
            cell = SalesItemListCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "DEFAULT")
        }
        cell?.updateDetails(item: salesViewModel.filteredSales?.documents?[indexPath.section].items[indexPath.row])
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat
    {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 145
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }
    
}
extension SalesViewController : UISearchBarDelegate, SalesModelViewDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        salesViewModel.applyFilter()
    }
    func getSearcText() -> String? {
        return searchBar.text
    }
    
}
