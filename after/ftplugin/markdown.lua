-- Buffer options for prose editing
vim.opt_local.wrap = true
vim.opt_local.spell = true
vim.opt_local.conceallevel = 2

local opts = function(desc)
  return { buffer = true, desc = desc }
end

-- Checkbox: insert new todo below
vim.keymap.set("n", "<leader>mt", "o- [ ] <Esc>", opts("Insert checkbox"))

-- Checkbox: toggle on current line
vim.keymap.set("n", "<leader>mx", function()
  local line = vim.api.nvim_get_current_line()
  if line:find("%[x%]") then
    line = line:gsub("%[x%]", "[ ]", 1)
  elseif line:find("%[ %]") then
    line = line:gsub("%[ %]", "[x]", 1)
  end
  vim.api.nvim_set_current_line(line)
end, opts("Toggle checkbox"))

-- Link: insert template (normal) / wrap selection (visual)
vim.keymap.set("n", "<leader>ml", "a[text](url)<Esc>F[lvt]", opts("Insert link"))
vim.keymap.set("v", "<leader>ml", '"zc[<C-r>z](url)<Esc>Fuvt)', opts("Wrap selection as link"))

-- Numbered list: auto-increment from previous line
vim.keymap.set("n", "<leader>mn", function()
  local prev = vim.fn.getline(vim.fn.line(".") - 1)
  local num = prev:match("^(%d+)%.")
  local next_num = num and (tonumber(num) + 1) or 1
  vim.api.nvim_put({ next_num .. ". " }, "l", true, false)
  vim.cmd("startinsert!")
end, opts("Insert numbered list item"))

-- Date: insert today's date at cursor
vim.keymap.set("n", "<leader>md", function()
  vim.api.nvim_put({ os.date("%Y-%m-%d") }, "c", true, true)
end, opts("Insert today's date"))

-- Bold: insert template (normal) / wrap selection (visual)
vim.keymap.set("n", "<leader>mb", "a****<Esc>hi", opts("Insert bold"))
vim.keymap.set("v", "<leader>mb", '"zc**<C-r>z**<Esc>', opts("Wrap selection in bold"))

-- Headings: factory for setting heading level
local function set_heading(level)
  return function()
    local line = vim.api.nvim_get_current_line()
    line = line:gsub("^#+ *", "")
    vim.api.nvim_set_current_line(string.rep("#", level) .. " " .. line)
  end
end

vim.keymap.set("n", "<leader>m1", set_heading(1), opts("Set heading level 1"))
vim.keymap.set("n", "<leader>m2", set_heading(2), opts("Set heading level 2"))
vim.keymap.set("n", "<leader>m3", set_heading(3), opts("Set heading level 3"))

-- Horizontal rule below
vim.keymap.set("n", "<leader>mr", "o---<Esc>", opts("Insert horizontal rule"))

-- Code block: insert (normal) / wrap selection (visual)
vim.keymap.set("n", "<leader>mc", "o```<CR><CR>```<Esc>ki", opts("Insert code block"))
vim.keymap.set("v", "<leader>mc", '"zc```<CR><C-r>z<CR>```<Esc>', opts("Wrap selection in code block"))

-- Warning callout block
vim.keymap.set("n", "<leader>mw", "o> [!IMPORTANT]<CR>> <Esc>A", opts("Insert important block"))

-- @mention: insert bold mention
vim.keymap.set("n", "<leader>mp", "a**@**<Esc>hi", opts("Insert @mention"))
