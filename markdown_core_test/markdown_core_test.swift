//
//  markdown_core_test.swift
//  markdown_core
//
//  Created by 秋星桥 on 7/7/25.
//

@testable import markdown_core
@testable import markdown_core_ast
import Testing

@Test func main() async throws {
    let result = markdown_rs_core_parse_to_ast_json(
        ###"""
        # Hello World
        """###
    )
    #expect(!result.isEmpty)
}

@Test func all_node_types() async throws {
    let jsonString = markdown_rs_core_parse_to_ast_json(
        ###"""
        ---
        title: 测试文档
        author: Copilot
        ---

        # 一级标题

        ## 二级标题

        ---

        > 这是引用

        - [ ] 未完成任务
        - [x] 已完成任务
        - 普通列表项
        1. 有序列表项

        **加粗** 和 *斜体* 以及 ~~删除线~~

        [链接](https://example.com "标题")

        ![图片alt](https://img.example.com "图片标题")

        [引用链接][ref]

        ![引用图片][imgref]

        [ref]: https://example.com "引用链接标题"
        [imgref]: https://img.example.com "引用图片标题"

        `行内代码`

        ```
        代码块
        ```

        <table>
          <tr>
            <td>HTML</td>
          </tr>
        </table>

        | 表头1 | 表头2 |
        |:-----:|------:|
        | 居中  | 右对齐 |

        $数学块$

        $$
        数学块内容
        $$

        这是一个脚注[^1]

        [^1]: 脚注定义
        """###
    )
    #expect(!jsonString.isEmpty)

    let ast = try MarkdownAbstractSyntaxTreeParser.parse(from: jsonString)
    #expect(ast.type == "root")
    #expect(ast.children.count > 0)
}
