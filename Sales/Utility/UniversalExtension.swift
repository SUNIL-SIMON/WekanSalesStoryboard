//
//  UniversalExtension.swift
//  Sales
//
//  Created by Sunil Simon on 15/10/23.
//

import Foundation
import Realm
import RealmSwift
extension String
{
    func getDate()->Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from:self)
        return date
    }
}
extension Date
{
    func getDate()->String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY, HH:mm"
        let date = dateFormatter.string(from: self)
        return date
    }
}
extension Results {
    func toList<T:Object>(type : T.Type) -> List<T> {
        var respList = List<T>()
        _ = self.reduce(List<T>()) { (list, element) -> List<T> in
            list.append(element as! T)
            respList = list
            return list
        }
        return respList
    }
}
