//  markdown_nodes.swift
//  markdown_core
//  Created by 秋星桥 on 7/7/25.

import Foundation

// MARK: - Concrete Nodes

public struct Root: ParentNode {
    public var type: String = "root"
    public var position: Position?
    public var children: [NodeWrapper]
}

public struct Paragraph: ParentNode {
    public var type: String = "paragraph"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
}

public struct Heading: ParentNode {
    public var type: String = "heading"
    public var position: Position?
    public var depth: Int // 1-6
    public var children: [NodeWrapper] // PhrasingContent
}

public struct ThematicBreak: Node {
    public var type: String = "thematicBreak"
    public var position: Position?
}

public struct Blockquote: ParentNode {
    public var type: String = "blockquote"
    public var position: Position?
    public var children: [NodeWrapper] // FlowContent
}

public struct List: ParentNode {
    public var type: String = "list"
    public var position: Position?
    public var ordered: Bool?
    public var start: Int?
    public var spread: Bool?
    public var children: [NodeWrapper] // ListContent
}

public struct ListItem: ParentNode {
    public var type: String = "listItem"
    public var position: Position?
    public var checked: Bool? // GFM
    public var spread: Bool?
    public var children: [NodeWrapper] // FlowContent
}

public struct Html: LiteralNode {
    public var type: String = "html"
    public var position: Position?
    public var value: String
}

public struct Code: LiteralNode {
    public var type: String = "code"
    public var position: Position?
    public var lang: String?
    public var meta: String?
    public var value: String
}

public struct Definition: Node, Association, Resource {
    public var type: String = "definition"
    public var position: Position?
    public var identifier: String
    public var label: String?
    public var url: String
    public var title: String?
}

public struct Text: LiteralNode {
    public var type: String = "text"
    public var position: Position?
    public var value: String
}

public struct Emphasis: ParentNode {
    public var type: String = "emphasis"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
}

public struct Strong: ParentNode {
    public var type: String = "strong"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
}

public struct InlineCode: LiteralNode {
    public var type: String = "inlineCode"
    public var position: Position?
    public var value: String
}

public struct Break: Node {
    public var type: String = "break"
    public var position: Position?
}

public struct Link: ParentNode, Resource {
    public var type: String = "link"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
    public var url: String
    public var title: String?
}

public struct Image: Node, Resource, Alternative {
    public var type: String = "image"
    public var position: Position?
    public var url: String
    public var title: String?
    public var alt: String?
}

public struct LinkReference: ParentNode, Reference {
    public var type: String = "linkReference"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
    public var identifier: String
    public var label: String?
    public var referenceType: ReferenceType
}

public struct ImageReference: Node, Reference, Alternative {
    public var type: String = "imageReference"
    public var position: Position?
    public var identifier: String
    public var label: String?
    public var referenceType: ReferenceType
    public var alt: String?
}

// GFM
public struct Delete: ParentNode {
    public var type: String = "delete"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
}

public struct FootnoteDefinition: ParentNode, Association {
    public var type: String = "footnoteDefinition"
    public var position: Position?
    public var children: [NodeWrapper] // FlowContent
    public var identifier: String
    public var label: String?
}

public struct FootnoteReference: Node, Association {
    public var type: String = "footnoteReference"
    public var position: Position?
    public var identifier: String
    public var label: String?
}

public struct Table: ParentNode {
    public var type: String = "table"
    public var position: Position?
    public var align: [AlignType?]?
    public var children: [NodeWrapper] // TableContent (TableRow)
}

public struct TableRow: ParentNode {
    public var type: String = "tableRow"
    public var position: Position?
    public var children: [NodeWrapper] // RowContent (TableCell)
}

public struct TableCell: ParentNode {
    public var type: String = "tableCell"
    public var position: Position?
    public var children: [NodeWrapper] // PhrasingContent
}

// Math
public struct Math: LiteralNode {
    public var type: String = "math"
    public var position: Position?
    public var value: String
    public var meta: String?
}

public struct InlineMath: LiteralNode {
    public var type: String = "inlineMath"
    public var position: Position?
    public var value: String
}
