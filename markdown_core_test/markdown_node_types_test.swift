//  markdown_node_types_test.swift
//  markdown_core
//  Created by Copilot on 2024/7/8.

@testable import markdown_core
@testable import markdown_core_ast
import Testing

@Test func ast_parse_root() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    # Hello World
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.type == "root")
    #expect(ast.children.count > 0)
}

@Test func ast_parse_paragraph() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    Hello world
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "paragraph")
}

@Test func ast_parse_heading() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    # Heading 1
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "heading")
}

@Test func ast_parse_thematicBreak() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    ---
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "thematicBreak")
}

@Test func ast_parse_blockquote() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    > quote
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "blockquote")
}

@Test func ast_parse_list() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    - item1
    - item2
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "list")
}

@Test func ast_parse_listItem() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    - item1
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .list(list) = ast.children.first {
        if case let .listItem(item) = list.children.first {
            #expect(item.type == "listItem")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_html() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    <div>html</div>
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "html")
}

@Test func ast_parse_code() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    ```swift
    let a = 1
    ```
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "code")
}

@Test func ast_parse_definition() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    [foo]: /url "title"
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.last?.type == "definition")
}

@Test func ast_parse_text() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    text
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .text(textNode) = para.children.first {
            #expect(textNode.type == "text")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_emphasis() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    *em*
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .emphasis(em) = para.children.first {
            #expect(em.type == "emphasis")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_strong() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    **strong**
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .strong(strong) = para.children.first {
            #expect(strong.type == "strong")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_inlineCode() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    `code`
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .inlineCode(code) = para.children.first {
            #expect(code.type == "inlineCode")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_break() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    line  
    break
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .breakNode(br) = para.children.dropLast().last {
            #expect(br.type == "break")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_link() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    [link](url)
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .link(link) = para.children.first {
            #expect(link.type == "link")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_image() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    ![alt](url)
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .image(img) = para.children.first {
            #expect(img.type == "image")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_linkReference() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    [foo][bar]

    [bar]: /url
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .linkReference(linkRef) = para.children.first {
            #expect(linkRef.type == "linkReference")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_imageReference() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    ![alt][bar]

    [bar]: /url
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .imageReference(imgRef) = para.children.first {
            #expect(imgRef.type == "imageReference")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_delete() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    ~~del~~
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .delete(del) = para.children.first {
            #expect(del.type == "delete")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_footnoteDefinition() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    [^1]: footnote
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.last?.type == "footnoteDefinition")
}

@Test func ast_parse_footnoteReference() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    footnote[^1]

    [^1]: footnote
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .footnoteReference(ref) = para.children.last {
            #expect(ref.type == "footnoteReference")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_table() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    | a | b |
    |---|---|
    | 1 | 2 |
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "table")
}

@Test func ast_parse_tableRow() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    | a | b |
    |---|---|
    | 1 | 2 |
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .table(table) = ast.children.first {
        if case let .tableRow(row) = table.children.first {
            #expect(row.type == "tableRow")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_tableCell() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    | a | b |
    |---|---|
    | 1 | 2 |
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .table(table) = ast.children.first {
        if case let .tableRow(row) = table.children.first {
            if case let .tableCell(cell) = row.children.first {
                #expect(cell.type == "tableCell")
            } else {
                #expect(Bool(false))
            }
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}

@Test func ast_parse_math() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    $$
    x+1
    $$
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    #expect(ast.children.first?.type == "math")
}

@Test func ast_parse_inlineMath() async throws {
    let json = markdown_rs_core_parse_to_ast_json(###"""
    $x+1$
    """###)
    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: json)
    if case let .paragraph(para) = ast.children.first {
        if case let .inlineMath(im) = para.children.first {
            #expect(im.type == "inlineMath")
        } else {
            #expect(Bool(false))
        }
    } else {
        #expect(Bool(false))
    }
}
