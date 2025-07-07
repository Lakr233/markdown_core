//  markdown_ast_parser.swift
//  markdown_core
//  Created by 秋星桥 on 7/7/25.

import Foundation

// MARK: - Markdown AST Parser

public enum MarkdownAbstractSyntaxTreeParser {
    public static func parse(from jsonString: String) throws -> Root {
        guard let data = jsonString.data(using: .utf8) else {
            throw MarkdownASTError.invalidUTF8
        }

        let decoder = JSONDecoder()
        let nodeWrapper = try decoder.decode(NodeWrapper.self, from: data)

        guard case let .root(root) = nodeWrapper else {
            throw MarkdownASTError.notRootNode
        }

        return root
    }

    public static func parseNode(from jsonString: String) throws -> NodeWrapper {
        guard let data = jsonString.data(using: .utf8) else {
            throw MarkdownASTError.invalidUTF8
        }

        let decoder = JSONDecoder()
        return try decoder.decode(NodeWrapper.self, from: data)
    }
}

// MARK: - Errors

public enum MarkdownASTError: Error, LocalizedError {
    case invalidUTF8
    case notRootNode
    case decodingError(String)

    public var errorDescription: String? {
        switch self {
        case .invalidUTF8:
            "Invalid UTF-8 encoding"
        case .notRootNode:
            "Parsed node is not a root node"
        case let .decodingError(message):
            "Decoding error: \(message)"
        }
    }
}
