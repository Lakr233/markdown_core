//
//  markdown_core.swift
//  markdown_core
//
//  Created by 秋星桥 on 7/7/25.
//

import markdown_bridge

public func markdown_rs_core_parse_to_ast_json(_ text: String) -> String {
    let astText = text.withCString { markdown_core_parse_to_mdast_json($0) }
    guard let astText else { return "" }
    defer { markdown_core_free_str(astText) }
    return String(cString: astText)
}
