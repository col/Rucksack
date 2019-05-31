//
//  Post.swift
//  RucksackTests
//
//  Created by Colin Harris on 30/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

import Rucksack

public class PostRelationships: Relationships {
    public var category: ResourceReference?
    public var authors: [ResourceReference]?

    private enum CodingKeys: CodingKey {
        case category
        case authors
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try container.decode(ResourceReference.self, forKey: .category)
        self.authors = try container.decode([ResourceReference].self, forKey: .authors)
    }
}

public class Post: Resource {
    public var id: String!
    public var title: String
    public var category: Category?
    public var authors: [Author]?
    public var relationships: Relationships?
    
    public func relationshipsType() -> Relationships.Type? {        
        return PostRelationships.self
    }
    
    public func assignRelationships(from included: [Resource]) {
        if let postRel = self.relationships as? PostRelationships {
            if let id = postRel.category?.id {
                self.category = included.filter { type(of: $0) == Category.self && $0.id == id }.first as? Category
            }
            
            self.authors = postRel.authors?.compactMap { authorRef in
                included.filter { type(of: $0) == Author.self && $0.id == authorRef.id }.first as? Author
            }
        }
    }
}
