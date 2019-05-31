//
//  ResourceResponse.swift
//  Rucksack
//
//  Created by Colin Harris on 26/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public class ResourceResponse: Response, Decodable {
//    public var errors: [ResponseError]?
    public var links: [String: String]?
    public var data: Resource
    public var included: [Resource]?
    
    init(data: Resource, included: [Resource]? = nil) {
        self.data = data
        self.included = included
    }
    
    private enum CodingKeys: CodingKey {
        case links
        case data
        case included
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let resourceWrapper = try container.decode(ResourceWrapper.self, forKey: .data)        
        self.data = resourceWrapper.resource!
        
        let includedResourceWrappers = try container.decode([ResourceWrapper].self, forKey: .included)
        self.included = includedResourceWrappers.compactMap { $0.resource }
        
        if let included = included {
            self.data.assignRelationships(from: included)
        }
    }
}
