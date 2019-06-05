//
//  CollectionResponseSpec.swift
//  RucksackTests
//
//  Created by Colin Harris on 30/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

import Quick
import Nimble
@testable import Rucksack

class CollectionResponseSpec: QuickSpec {
    override func spec() {
        beforeEach {
            ResourceTypeRegistry.addType(Post.self, for: "Post")
            ResourceTypeRegistry.addType(Category.self, for: "Category")
            ResourceTypeRegistry.addType(Author.self, for: "Author")
        }
        
        it("correctly decodes a collection document") {
            let jsonData = """
                {
                    "data": [
                        {
                            "id": "1",
                            "type": "Post",
                            "attributes": {
                                "title": "Blah Blah"
                            },
                            "relationships": {
                                "category": {
                                    "data": { "id": "2", "type": "Category" }
                                },
                                "authors": [
                                    { "data": { "id": "3", "type": "Author" } },
                                    { "data": { "id": "4", "type": "Author" } }
                                ]
                            }
                        }
                    ],
                    "included": [
                        {
                            "id": "3",
                            "type": "Author",
                            "attributes": {
                                "name": "John Smith"
                            }
                        },
                        {
                            "id": "4",
                            "type": "Author",
                            "attributes": {
                                "name": "Joe Blow"
                            }
                        },
                        {
                            "id": "2",
                            "type": "Category",
                            "attributes": {
                                "name": "Featured"
                            }
                        }
                    ]
                }
                """.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try! decoder.decode(CollectionResponse.self, from: jsonData)
            
            expect(response.data?.count).to(equal(1))
            
            expect(response.data?[0]).to(beAKindOf(Post.self))
            let post = response.data?[0] as! Post
            expect(post.id).to(equal("1"))
            expect(post.title).to(equal("Blah Blah"))
            // Category
            expect(post.category?.id).to(equal("2"))
            expect(post.category?.name).to(equal("Featured"))
            // Authors
            expect(post.authors?.count).to(equal(2))
            expect(post.authors?[0].id).to(equal("3"))
            expect(post.authors?[0].name).to(equal("John Smith"))
            expect(post.authors?[1].id).to(equal("4"))
            expect(post.authors?[1].name).to(equal("Joe Blow"))
            
            // Included
            expect(response.included?.count).to(equal(3))

            expect(response.included?[0]).to(beAKindOf(Author.self))
            let author = response.included?[0] as! Author
            expect(author.id).to(equal("3"))
            expect(author.name).to(equal("John Smith"))
            
            expect(response.included?[1]).to(beAKindOf(Author.self))
            let author2 = response.included?[1] as! Author
            expect(author2.id).to(equal("4"))
            expect(author2.name).to(equal("Joe Blow"))
            
            expect(response.included?[2]).to(beAKindOf(Category.self))
            let category = response.included?[2] as! Category
            expect(category.id).to(equal("2"))
            expect(category.name).to(equal("Featured"))
        }
        
        it("handles errors correctly") {
            let jsonData = """
                {
                    "errors": [
                        {
                            "id": "asdf-qwer-zxcv",
                            "status": "404",
                            "code": "resource-not-found",
                            "title": "Error",
                            "detail": "Resource Not Found"
                        }
                    ]
                }
                """.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try! decoder.decode(CollectionResponse.self, from: jsonData)
            
            expect(response.data).to(beNil())
            expect(response.errors?.count).to(equal(1))
            let error = response.errors?[0]
            expect(error?.id).to(equal("asdf-qwer-zxcv"))
            expect(error?.status).to(equal("404"))
            expect(error?.code).to(equal("resource-not-found"))
            expect(error?.title).to(equal("Error"))
            expect(error?.detail).to(equal("Resource Not Found"))
        }
    }
}

