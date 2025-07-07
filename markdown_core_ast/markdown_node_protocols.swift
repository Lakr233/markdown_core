//  markdown_node_protocols.swift
//  markdown_core
//  Created by 秋星桥 on 7/7/25.

import Foundation

// MARK: - Position

public struct Point: Codable, Sendable, Equatable, Hashable {
    public var line: Int
    public var column: Int
    public var offset: Int
}

public struct Position: Codable, Sendable, Equatable, Hashable {
    public var start: Point
    public var end: Point
}

// MARK: - Protocols and Mixins

public protocol Node: Codable, Sendable, Equatable, Hashable {
    var type: String { get }
    var position: Position? { get }
}

public protocol LiteralNode: Node {
    var value: String { get }
}

public protocol ParentNode: Node {
    var children: [NodeWrapper] { get }
}

public protocol Alternative: Codable, Sendable, Equatable, Hashable {
    var alt: String? { get }
}

public protocol Association: Codable, Sendable, Equatable, Hashable {
    var identifier: String { get }
    var label: String? { get }
}

public protocol Resource: Codable, Sendable, Equatable, Hashable {
    var url: String { get }
    var title: String? { get }
}

public enum ReferenceType: String, Codable, Sendable, Equatable, Hashable {
    case shortcut
    case collapsed
    case full
}

public protocol Reference: Association {
    var referenceType: ReferenceType { get }
}

public enum AlignType: String, Codable, Sendable, Equatable, Hashable {
    case left
    case right
    case center
}
