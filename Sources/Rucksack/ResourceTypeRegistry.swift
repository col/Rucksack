//
//  ResourceTypeRegistry.swift
//  Rucksack
//
//  Created by Colin Harris on 30/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public class ResourceTypeRegistry {
    static var registeredTypes: [String: Resource.Type] = [:]
    
    public class func type(for name: String) -> Resource.Type? {
        return registeredTypes[name]
    }
    
    public class func addType(_ type: Resource.Type, for name: String) {
        registeredTypes[name] = type
    }
}
