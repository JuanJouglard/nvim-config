
-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost lua/jayjay/packer.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end
-- Install plugins
return packer.startup(function(use)
    -- Markers plugin
    use { 'chentoast/marks.nvim', config = function() require'marks'.setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
    } end }
    -- Add you plugins here:
    use 'wbthomason/packer.nvim' -- packer can manage itself

    -- File explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Indent line
    use 'lukas-reineke/indent-blankline.nvim'

    -- Autopair
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup{}
        end
    }

    -- Icons
    use 'kyazdani42/nvim-web-devicons'

    -- Tag viewer
    use 'preservim/tagbar'

    -- Treesitter interface
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    use {
        'crusj/bookmarks.nvim',
        branch = 'main',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require("bookmarks").setup()
            require("telescope").load_extension("bookmarks")
        end
    }

    --use { 'nvim-treesitter/nvim-treesitter-context', config = function ()
    --    require'treesitter-context'.setup({
    --        enable = true,
    --    })
    --end }

    -- Color schemes
    use 'navarasu/onedark.nvim'
    use 'tanvirtin/monokai.nvim'
    use 'bluz71/vim-nightfly-guicolors'

    use('mbbill/undotree')

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }


    -- Statusline
    use {
        'feline-nvim/feline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    -- git labels
    use {
        'lewis6991/gitsigns.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('gitsigns').setup{}
        end
    }

    -- Dashboard (start screen)
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'samoshkin/vim-mergetool' }
    use { 'tpope/vim-fugitive' }

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use {'nvim-telescope/telescope.nvim', tag="0.1.0" }
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function ()
        require"octo".setup()
      end
    }
    use({'ckipp01/nvim-jenkinsfile-linter', requires = { "nvim-lua/plenary.nvim" } })
end)
