//  markdown_node_wrapper.swift
//  markdown_core
//  Created by 秋星桥 on 7/7/25.

import Foundation

@dynamicMemberLookup
public enum NodeWrapper: Codable, Sendable, Equatable, Hashable {
    case blockquote(Blockquote)
    case breakNode(Break)
    case code(Code)
    case definition(Definition)
    case delete(Delete)
    case emphasis(Emphasis)
    case footnoteDefinition(FootnoteDefinition)
    case footnoteReference(FootnoteReference)
    case heading(Heading)
    case html(Html)
    case image(Image)
    case imageReference(ImageReference)
    case inlineCode(InlineCode)
    case inlineMath(InlineMath)
    case link(Link)
    case linkReference(LinkReference)
    case list(List)
    case listItem(ListItem)
    case math(Math)
    case paragraph(Paragraph)
    case root(Root)
    case strong(Strong)
    case table(Table)
    case tableCell(TableCell)
    case tableRow(TableRow)
    case text(Text)
    case thematicBreak(ThematicBreak)
    case toml(Toml)
    case yaml(Yaml)

    private enum CodingKeys: String, CodingKey {
        case type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "blockquote": self = try .blockquote(Blockquote(from: decoder))
        case "break": self = try .breakNode(Break(from: decoder))
        case "code": self = try .code(Code(from: decoder))
        case "definition": self = try .definition(Definition(from: decoder))
        case "delete": self = try .delete(Delete(from: decoder))
        case "emphasis": self = try .emphasis(Emphasis(from: decoder))
        case "footnoteDefinition": self = try .footnoteDefinition(FootnoteDefinition(from: decoder))
        case "footnoteReference": self = try .footnoteReference(FootnoteReference(from: decoder))
        case "heading": self = try .heading(Heading(from: decoder))
        case "html": self = try .html(Html(from: decoder))
        case "image": self = try .image(Image(from: decoder))
        case "imageReference": self = try .imageReference(ImageReference(from: decoder))
        case "inlineCode": self = try .inlineCode(InlineCode(from: decoder))
        case "inlineMath": self = try .inlineMath(InlineMath(from: decoder))
        case "link": self = try .link(Link(from: decoder))
        case "linkReference": self = try .linkReference(LinkReference(from: decoder))
        case "list": self = try .list(List(from: decoder))
        case "listItem": self = try .listItem(ListItem(from: decoder))
        case "math": self = try .math(Math(from: decoder))
        case "paragraph": self = try .paragraph(Paragraph(from: decoder))
        case "root": self = try .root(Root(from: decoder))
        case "strong": self = try .strong(Strong(from: decoder))
        case "table": self = try .table(Table(from: decoder))
        case "tableCell": self = try .tableCell(TableCell(from: decoder))
        case "tableRow": self = try .tableRow(TableRow(from: decoder))
        case "text": self = try .text(Text(from: decoder))
        case "thematicBreak": self = try .thematicBreak(ThematicBreak(from: decoder))
        case "toml": self = try .toml(Toml(from: decoder))
        case "yaml": self = try .yaml(Yaml(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown node type: \(type)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .blockquote(node): try node.encode(to: encoder)
        case let .breakNode(node): try node.encode(to: encoder)
        case let .code(node): try node.encode(to: encoder)
        case let .definition(node): try node.encode(to: encoder)
        case let .delete(node): try node.encode(to: encoder)
        case let .emphasis(node): try node.encode(to: encoder)
        case let .footnoteDefinition(node): try node.encode(to: encoder)
        case let .footnoteReference(node): try node.encode(to: encoder)
        case let .heading(node): try node.encode(to: encoder)
        case let .html(node): try node.encode(to: encoder)
        case let .image(node): try node.encode(to: encoder)
        case let .imageReference(node): try node.encode(to: encoder)
        case let .inlineCode(node): try node.encode(to: encoder)
        case let .inlineMath(node): try node.encode(to: encoder)
        case let .link(node): try node.encode(to: encoder)
        case let .linkReference(node): try node.encode(to: encoder)
        case let .list(node): try node.encode(to: encoder)
        case let .listItem(node): try node.encode(to: encoder)
        case let .math(node): try node.encode(to: encoder)
        case let .paragraph(node): try node.encode(to: encoder)
        case let .root(node): try node.encode(to: encoder)
        case let .strong(node): try node.encode(to: encoder)
        case let .table(node): try node.encode(to: encoder)
        case let .tableCell(node): try node.encode(to: encoder)
        case let .tableRow(node): try node.encode(to: encoder)
        case let .text(node): try node.encode(to: encoder)
        case let .thematicBreak(node): try node.encode(to: encoder)
        case let .toml(node): try node.encode(to: encoder)
        case let .yaml(node): try node.encode(to: encoder)
        }
    }

    public var node: any Node {
        switch self {
        case let .blockquote(node): node
        case let .breakNode(node): node
        case let .code(node): node
        case let .definition(node): node
        case let .delete(node): node
        case let .emphasis(node): node
        case let .footnoteDefinition(node): node
        case let .footnoteReference(node): node
        case let .heading(node): node
        case let .html(node): node
        case let .image(node): node
        case let .imageReference(node): node
        case let .inlineCode(node): node
        case let .inlineMath(node): node
        case let .link(node): node
        case let .linkReference(node): node
        case let .list(node): node
        case let .listItem(node): node
        case let .math(node): node
        case let .paragraph(node): node
        case let .root(node): node
        case let .strong(node): node
        case let .table(node): node
        case let .tableCell(node): node
        case let .tableRow(node): node
        case let .text(node): node
        case let .thematicBreak(node): node
        case let .toml(node): node
        case let .yaml(node): node
        }
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<any Node, T>) -> T {
        node[keyPath: keyPath]
    }
}
