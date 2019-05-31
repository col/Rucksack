//
//  Response.swift
//  Rucksack
//
//  Created by Colin Harris on 26/5/19.
//  Copyright © 2019 Colin Harris. All rights reserved.
//

public protocol Response {
//    var errors: [ResponseError]? { get }
    var links: [String: String]? { get }
}
