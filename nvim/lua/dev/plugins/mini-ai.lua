return {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = function()
        local ai = require("mini.ai")
        return {
            -- Table with textobject id as fields, textobject specification as values.
            -- Also use this to disable builtin textobjects. See |MiniAi.config|.
            custom_textobjects = {
                -- Code block objects
                o = ai.gen_spec.treesitter({
                    a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                    i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                }, {}),
                
                -- Function call textobject
                u = ai.gen_spec.function_call(), -- u for "Usage"
                U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), 
                
                -- Number/digit textobject  
                d = { "%f[%d]%d+" }, -- digits
                
                -- Enhanced word with case (camelCase, snake_case)
                e = {
                    {
                        "%u[%l%d]+%f[^%l%d]", -- CamelCase
                        "%f[%S][%l%d]+%f[^%l%d]", -- snake_case part
                        "%f[%P][%l%d]+%f[^%l%d]", -- punctuation boundary
                        "^[%l%d]+%f[^%l%d]", -- start of line
                    },
                    "^().*()$",
                },
                
                -- Entire buffer
                g = function()
                    local from = { line = 1, col = 1 }
                    local to = {
                        line = vim.fn.line("$"),
                        col = math.max(vim.fn.getline("$"):len(), 1)
                    }
                    return { from = from, to = to }
                end,
                
                -- Line textobject (without line ending)
                L = function()
                    local line_num = vim.fn.line(".")
                    local line_content = vim.fn.getline(line_num)
                    local from = { line = line_num, col = 1 }
                    local to = { line = line_num, col = line_content:len() }
                    return { from = from, to = to }
                end,
                
                -- Indent-based textobject (useful for Python)
                I = function(ai_type)
                    local line_num = vim.fn.line(".")
                    local indent = vim.fn.indent(line_num)
                    local start_line = line_num
                    local end_line = line_num
                    
                    -- Find start of block
                    while start_line > 1 do
                        local prev_line = start_line - 1
                        local prev_indent = vim.fn.indent(prev_line)
                        local prev_content = vim.fn.getline(prev_line):match("^%s*(.*)$")
                        
                        if prev_content == "" then
                            start_line = prev_line
                        elseif prev_indent < indent then
                            break
                        else
                            start_line = prev_line
                        end
                    end
                    
                    -- Find end of block
                    local total_lines = vim.fn.line("$")
                    while end_line < total_lines do
                        local next_line = end_line + 1
                        local next_indent = vim.fn.indent(next_line)
                        local next_content = vim.fn.getline(next_line):match("^%s*(.*)$")
                        
                        if next_content == "" then
                            end_line = next_line
                        elseif next_indent < indent then
                            break
                        else
                            end_line = next_line
                        end
                    end
                    
                    local from = { line = start_line, col = 1 }
                    local to = { line = end_line, col = vim.fn.getline(end_line):len() }
                    
                    if ai_type == "i" then
                        -- For inner, exclude surrounding empty lines
                        while start_line <= end_line and vim.fn.getline(start_line):match("^%s*$") do
                            start_line = start_line + 1
                        end
                        while end_line >= start_line and vim.fn.getline(end_line):match("^%s*$") do
                            end_line = end_line - 1
                        end
                        from = { line = start_line, col = 1 }
                        to = { line = end_line, col = vim.fn.getline(end_line):len() }
                    end
                    
                    return { from = from, to = to }
                end,
            },
            
            -- Module mappings. Use `""` (empty string) to disable one.
            mappings = {
                -- Main textobject prefixes
                around = 'a',
                inside = 'i',
                
                -- Next/last variants
                around_next = 'an',
                inside_next = 'in',
                around_last = 'al',
                inside_last = 'il',
                
                -- Move cursor to corresponding edge of `a` textobject
                goto_left = 'g[',
                goto_right = 'g]',
            },
            
            -- Number of lines within which textobject is searched
            n_lines = 500,
            
            -- How to search for object (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
            search_method = 'cover_or_next',
        }
    end,
    config = function(_, opts)
        require("mini.ai").setup(opts)
        
        -- Add which-key descriptions
        local objects = {
            { " ", desc = "whitespace" },
            { '"', desc = 'balanced "' },
            { "'", desc = "balanced '" },
            { "(", desc = "balanced (" },
            { ")", desc = "balanced ) including white-space" },
            { ">", desc = "balanced > including white-space" },
            { "?", desc = "user prompt" },
            { "U", desc = "use/call without arguments" },
            { "[", desc = "balanced [" },
            { "]", desc = "balanced ] including white-space" },
            { "_", desc = "underscore" },
            { "`", desc = "balanced `" },
            { "a", desc = "argument" },
            { "b", desc = "balanced )]}" },
            { "c", desc = "class" },
            { "d", desc = "digit(s)" },
            { "e", desc = "word in CamelCase & snake_case" },
            { "f", desc = "function" },
            { "g", desc = "entire buffer" },
            { "i", desc = "indent" },
            { "o", desc = "block, conditional, loop" },
            { "q", desc = "quote `\"'`" },
            { "t", desc = "tag" },
            { "u", desc = "use/call function & method" },
            { "{", desc = "balanced {" },
            { "}", desc = "balanced } including white-space" },
            { "I", desc = "indent-based (Python-like)" },
            { "L", desc = "line without line ending" },
        }
        
        local ret = { mode = { "o", "x" } }
        for prefix, name in pairs({
            i = "inside",
            a = "around",
            il = "last inside",
            al = "last around", 
            ["in"] = "next inside",  -- Quote the reserved keyword
            an = "next around",
        }) do
            ret[#ret + 1] = { prefix, group = name }
            for _, obj in ipairs(objects) do
                ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
            end
        end
        
        if pcall(require, "which-key") then
            require("which-key").add(ret, { notify = false })
        end
    end,
}