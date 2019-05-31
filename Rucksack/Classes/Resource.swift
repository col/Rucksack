//
//  Resource.swift
//  Rucksack
//
//  Created by Colin Harris on 26/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public protocol Resource: Decodable {
    var id: String! { get set }    
    var relationships: Relationships? { get set }
    func relationshipsType() -> Relationships.Type?
    func assignRelationships(from: [Resource])
}

extension Resource {
    public func relationshipsType() -> Relationships.Type? {
        return nil
    }
    
    public func assignRelationships(from included: [Resource]) {
    }
}
