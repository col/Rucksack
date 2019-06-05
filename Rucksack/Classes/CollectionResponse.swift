//
//  CollectionResponse.swift
//  Rucksack
//
//  Created by Colin Harris on 26/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public class CollectionResponse: Response, Decodable {
    public var errors: [ResponseError]?
    public var links: [String: String]?
    public var data: [Resource]?
    public var included: [Resource]?
    
    public init(data: [Resource], included: [Resource]? = nil) {
        self.data = data
        self.included = included
    }
    
    private enum CodingKeys: CodingKey {
        case links
        case data
        case included
        case errors
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.errors) {
            self.errors = try container.decode([ResponseError].self, forKey: .errors)
        }
        
        if container.contains(.data) {
            let resourceWrappers = try container.decode([ResourceWrapper].self, forKey: .data)
            self.data = resourceWrappers.compactMap { $0.resource }
        }
        
        if container.contains(.included) {
            let includedResourceWrappers = try container.decode([ResourceWrapper].self, forKey: .included)
            self.included = includedResourceWrappers.compactMap { $0.resource }
        }
        
        if let included = included {
            self.data?.forEach { resource in
                resource.assignRelationships(from: included)
            }
        }
    }
}

