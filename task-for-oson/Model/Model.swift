//
//  Model.swift
//  task-for-oson
//
//  Created by Fedya on 26/05/23.
//

import Foundation

struct CategoryData: Codable {
    var categoryList: CategoryList?
    
    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}


struct CategoryList: Codable {
    var count: Int?
    var array: [Category]?
    
    
    func makeTree() -> [Category]? {
        
        var sortedList: [Category] = []
        
        
        if let array {
            
            for i in 0..<array.count {
                
                var element = array[i]
                
                if element.parentId != 0 {
                    continue
                }else {
                    var childList: [Category] = []
                    
                    for j in array where j.parentId == element.id
                    { childList.append(j) }
                    
                    element.childs = childList
                    sortedList.append(element)
                }
                
            }
            return sortedList
            
        }
        
        return []
    }

}

struct Category: Codable {
    var id: Int?
    var parentId: Int?
    var childs: [Category]?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentId = "parent_id"
        case childs
    }
}
