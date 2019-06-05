//
//  ResponseError.swift
//  Nimble
//
//  Created by Colin Harris on 4/6/19.
//

public struct ResponseError: Decodable {
    public var id: String?
    public var status: String?
    public var code: String?
    public var title: String?
    public var detail: String?
}
