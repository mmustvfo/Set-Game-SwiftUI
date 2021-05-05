//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Mustafo on 25/02/21.
//

import Foundation

extension Array where Element:Identifiable{
    func firstIndex(of matching:Element)-> Int?{
        for index in 0..<self.count{
            if self[index].id == matching.id{
                return index
            }
        }
        return 0
    }
}
