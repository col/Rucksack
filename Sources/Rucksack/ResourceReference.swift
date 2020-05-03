//
//  ResourceReference.swift
//  Rucksack
//
//  Created by Colin Harris on 30/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public struct ResourceReference {
    public var id: String
    public var type: String
}

extension ResourceReference: Decodable {
    private enum DataCodingKeys: CodingKey {
        case data
    }
    
    private enum CodingKeys: CodingKey {
        case id
        case type
    }
    
    public init(from decoder: Decoder) throws {
        let dataContainer = try decoder.container(keyedBy: DataCodingKeys.self)
                
        if dataContainer.contains(.data) {
            let container = try dataContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
            self.id = try container.decode(String.self, forKey: .id)
            self.type = try container.decode(String.self, forKey: .type)
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.type = try container.decode(String.self, forKey: .type)
        }
    }
}
