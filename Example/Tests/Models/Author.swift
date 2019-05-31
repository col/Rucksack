//
//  Author.swift
//  RucksackTests
//
//  Created by Colin Harris on 30/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

import Rucksack

public struct Author: Resource {
    public var id: String!
    public var name: String
    public var relationships: Relationships?
}
