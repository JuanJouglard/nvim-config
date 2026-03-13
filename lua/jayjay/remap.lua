vim.g.mapleader = ","
-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Set custom keymap for GitHub Copilot suggestion acceptance
vim.api.nvim_set_keymap("i", "<C-c>", "copilot#Accept('\\<CR>')", { silent = true, expr = true, script = true })

map('n', '<C-j>', '10j')
map('n', '<C-k>', '10k')
map('n', '<C-l>', ':+tabnext<CR>')
map('n', '<C-h>', ':-tabnext<CR>')

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Fast saving
map('n', '<C-s>', ':w!<CR>')
map('i', '<C-s>', '<ESC>:w!<CR>')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')
map('i', 'ff', '<ESC>')

-- Move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

map("v", "p", '"0dP')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Terminal mappings
map('n', '<C-t>', ':Term<CR>', { noremap = true })  -- open
map('t', '<Esc>', '<C-\\><C-n>')                    -- exit

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Tagbar
map('n', '<leader>z', ':TagbarToggle<CR>')          -- open/close

-- Edit code with ChatGPT
map('v', '<leader>eg', 'y:ChatGPTEditWithInstructions<CR>')

-- Telescope
map('n', '<C-p>', ':Telescope find_files<CR>')
map('n', '<C-f>', ':Telescope current_buffer_fuzzy_find<CR>')

-- hop.nvim
map('n', 'sc', ':HopChar2<CR>')
map('n', 'sl', ':HopLine<CR>')

-- Add new line but stay in Normal mode
map('n', '<leader>o', "o<ESC>")

map('v', "<leader>f", ":LspZeroFormat<CR>")
map("n", "<leader>se", ":lua vim.diagnostic.open_float()<CR>")
map("n", "<leader>qf", ":lua vim.lsp.buf.code_action()<CR>")

-- console.log
map("n", "<leader>cl", "yiwoconsole.log(\"<ESC>pa: \",<ESC>pa)<ESC>")

-- Choose which version to keep
map('n', "<leader>kl", ":diffget//2<CR>")
map('n', "<leader>kr", ":diffget//3<CR>")

map('i', "<C-d>", "<BS>", { noremap = true})

-- Git
vim.api.nvim_create_user_command("Status", "Gtabedit :", {})

map("n", "<Leader>rf",
  [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR><ESC>]],
  {noremap = true, silent = true})

-- Trouble
map('n', '<leader>xx', ':Trouble diagnostics toggle<CR>')
map('n', '<leader>xd', ':Trouble diagnostics toggle filter.buf=0<CR>')
map('n', '<leader>xq', ':Trouble quickfix toggle<CR>')

-- Copy current filepath to clipboard
vim.keymap.set('n', '<leader>cf', function()
  local filepath = vim.fn.expand('%:p')
  print("filepath: ",filepath)
  vim.fn.setreg('+', filepath)
  print('Copied to clipboard: ' .. filepath)
end, { noremap = true, silent = false })

