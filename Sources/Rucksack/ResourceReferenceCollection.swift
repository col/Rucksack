//
//  ResourceReferenceCollection.swift
//  Rucksack
//
//  Created by Colin Harris on 3/5/20.
//  Copyright © 2020 Colin Harris. All rights reserved.
//

public class ResourceReferenceCollection: Decodable {    
    public var links: [String: String]?
    public var data: [ResourceReference]?
    
    public init(data: [ResourceReference], links: [String: String] = [:]) {
        self.data = data
        self.links = links
    }
    
    private enum CodingKeys: CodingKey {
        case links
        case data
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.data) {
            self.data = try container.decode([ResourceReference].self, forKey: .data)            
        }
    }
}
