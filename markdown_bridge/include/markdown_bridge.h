#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

char *markdown_core_parse_to_mdast_json(const char *c_str);

void markdown_core_free_str(char *ptr);
