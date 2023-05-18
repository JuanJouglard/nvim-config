local api = vim.api

local chatgptapi = require('jayjay.chatgpt-api')

local function get_visual_selection()
    local startRow, _ = unpack(api.nvim_buf_get_mark(0, '<'))
    local endRow, _ = unpack(api.nvim_buf_get_mark(0, '>'))
    local text = api.nvim_buf_get_lines(0, startRow - 1, endRow, false)
    for _, v in ipairs(text) do
        print(v)
    end

    chatgptapi.explainCode("console.log('hola')", function(output_txt)
        print("OUTPUT", output_txt)
    end)
end

api.nvim_create_user_command('ExplainCode', function() get_visual_selection() end, { nargs = 0, range=true, desc = "Explain the piece of selected code"})
