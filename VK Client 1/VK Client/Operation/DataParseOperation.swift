//
//  DataParseOperation.swift
//  VK Client
//
//  Created by Анастасия Живаева on 13.06.2021.
//

import Foundation

class DataParseOperation: Operation {
    
    private(set) var outputData: [Group] = []
    
    override func main() {
        guard let getDataOperation = dependencies.first(where: { $0 is GetDataOperation}) as? GetDataOperation,
              let data = getDataOperation.data
        else {
            print("Data not loaded")
            return
        }
        
        do {
            let groups = try JSONDecoder().decode(GroupList.self, from: data)
            outputData = groups.response.items
        } catch {
            print("Data to decode failed")
        }
    }
}
