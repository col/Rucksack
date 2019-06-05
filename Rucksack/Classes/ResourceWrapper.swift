//
//  ResourceWrapper.swift
//  Rucksack
//
//  Created by Colin Harris on 30/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public struct ResourceWrapper {
    public var resource: Resource?    
}

extension ResourceWrapper: Decodable {
    private enum CodingKeys: CodingKey {
        case id
        case type
        case attributes
        case relationships
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeString = try container.decode(String.self, forKey: .type)
        
        if let type = ResourceTypeRegistry.type(for: typeString) {
            let id = try container.decode(String.self, forKey: .id)
            self.resource = try type.init(from: container.superDecoder(forKey: .attributes))
            self.resource?.id = id
            if container.contains(.relationships) {
                let relationshipsType = self.resource?.relationshipsType()
                self.resource?.relationships = try relationshipsType?.init(from: container.superDecoder(forKey: .relationships))
            }
        } else {
            print("Unknown resource type: \(typeString)")
        }
    }
}
