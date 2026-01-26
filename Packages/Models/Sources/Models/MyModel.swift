//
//  MyModel.swift
//  Models
//
//  Created by Michael Tibollo on 2026-01-26.
//

import Foundation

public struct MyModel: Decodable, Hashable {
    public let id: UUID
    public let latitude: Double
    public let longitude: Double
    public let name: String
    public let ownerId: UUID?
}
