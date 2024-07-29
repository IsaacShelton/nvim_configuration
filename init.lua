vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Goto previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
vim.opt.whichwrap:append '<>[]hl'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

local symbols = {
  ERROR = '󰅙',
  WARN = '',
  INFO = '󰋼',
  HINT = '󰌵',
}

-- Configure diagnostic symbols and virtual text
do
  local x = vim.diagnostic.severity

  vim.diagnostic.config {
    virtual_text = {
      -- prefix = '',
    },
    signs = { text = { [x.ERROR] = symbols.ERROR, [x.WARN] = symbols.WARN, [x.INFO] = symbols.INFO, [x.HINT] = symbols.HINT } },
    underline = true,
    float = { border = 'single' },
  }

  local signs = {
    Error = symbols.ERROR .. ' ',
    Warn = symbols.WARN .. ' ',
    Info = symbols.INFO .. ' ',
    Hint = symbols.HINT .. ' ',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

-- Minimal number of screen lines to keep above and below the cursor.
-- vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Disable automatic comment continuation
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  command = 'setlocal formatoptions-=ro',
})

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>;', '<cmd>w<CR>')
vim.keymap.set('n', '<leader>:', '<cmd>wqa<CR>')

-- Nicities and spider
vim.keymap.set({ 'n', 'v' }, '∆', '}')
vim.keymap.set({ 'n', 'v' }, '˚', '{')
vim.keymap.set({ 'n', 'v' }, '[f', '[{[{[{[{[{[{[{[{[{[{[{[{')
vim.keymap.set({ 'n', 'v' }, ']f', ']}]}]}]}]}]}]}]}]}]}]}]}')
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>w', "<cmd>lua require('spider').motion('w')<cr>", { desc = 'spider-w' })
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>e', "<cmd>lua require('spider').motion('e')<cr>", { desc = 'spider-e' })
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>b', "<cmd>lua require('spider').motion('b')<cr>", { desc = 'spider-b' })
vim.keymap.set({ 'n', 'o', 'x' }, '<leader>ge', "<cmd>lua require('spider').motion('ge')<cr>", { desc = 'spider-ge' })
vim.keymap.set({ 'i' }, '<Esc><BS>', '<C-w>', { desc = 'option+backspace to delete word in insert mode' })
vim.keymap.set({ 'i' }, '<C-l>', '<right>', { desc = 'Move right in insert mode' })
vim.keymap.set({ 'i' }, '<C-h>', '<left>', { desc = 'Move left in insert mode' })
vim.keymap.set({ 'i' }, '<C-k>', '<up>', { desc = 'Move up in insert mode' })
vim.keymap.set({ 'i' }, '<C-j>', '<down>', { desc = 'Move down in insert mode' })

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<leader>a', '<cmd> Telescope find_files <CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>q', '<cmd> Telescope diagnostics <CR>', { desc = 'List all diagnostics' })
vim.keymap.set('n', '<leader>1', '<cmd> Telescope diagnostics severity=1<CR>', { desc = 'List error diagnostics' })
vim.keymap.set('n', '<leader>2', '<cmd> Telescope diagnostics severity=2<CR>', { desc = 'List warning diagnostics' })
vim.keymap.set('n', '<leader>3', '<cmd> Telescope diagnostics severity=3<CR>', { desc = 'List info diagnostics' })
vim.keymap.set('n', '<leader>4', '<cmd> Telescope diagnostics severity=4<CR>', { desc = 'List hint diagnostics' })
vim.keymap.set('n', '<leader>fa', '<cmd> Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = 'Find all' })
vim.keymap.set('n', '<leader>fw', '<cmd> Telescope live_grep<CR>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', '<cmd> Telescope buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', '<cmd> Telescope help_tags<CR>', { desc = 'Help page' })
vim.keymap.set('n', '<leader>fo', '<cmd> Telescope oldfiles<CR>', { desc = 'Find oldfiles' })
vim.keymap.set('n', '<leader>fs', '<cmd> Telescope lsp_dynamic_workspace_symbols<CR>', { desc = 'Find symbol' })
vim.keymap.set('n', '<leader>fc', '<cmd> Telescope git_commits<CR>', { desc = 'Find commit' })
vim.keymap.set('n', '<leader>ft', '<cmd> Telescope git_status<CR>', { desc = 'Find status' })
vim.keymap.set('n', '<leader>fm', '<cmd> Telescope marks<CR>', { desc = 'Find bookmark' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use tab/shift-tab to cycle between buffers
vim.keymap.set('n', '<tab>', '<CMD>bnext<CR>', { desc = 'Goto next tab' })
vim.keymap.set('n', '<S-tab>', '<CMD>bprev<CR>', { desc = 'Goto previous tab' })

-- Keymap to toggle between dark/light theme
vim.keymap.set('n', '<leader>th', function()
  print 'toggling'
  if vim.g.colors_name == 'nord' then
    vim.cmd [[ colorscheme ayu-light ]]
  else
    vim.cmd [[ colorscheme nord ]]
  end
end, { desc = 'Toggle dark/light theme' })

-- Allow for <leader>d to delete line
vim.keymap.set({ 'n', 'x', 'v' }, '<leader>d', 'dd', { desc = 'Fast delete line' })

-- [[ Keymaps for jumping between different kinds of diagnostics ]]
vim.keymap.set({ 'n' }, ']1', function()
  vim.diagnostic.goto_next { severity = 1 }
end, { desc = 'Go to next error' })
vim.keymap.set({ 'n' }, '[1', function()
  vim.diagnostic.goto_prev { severity = 1 }
end, { desc = 'Go to previous error' })

vim.keymap.set({ 'n' }, ']2', function()
  vim.diagnostic.goto_next { severity = 2 }
end, { desc = 'Go to next warning' })
vim.keymap.set({ 'n' }, '[2', function()
  vim.diagnostic.goto_prev { severity = 2 }
end, { desc = 'Go to previous warning' })

vim.keymap.set({ 'n' }, ']3', function()
  vim.diagnostic.goto_next { severity = 3 }
end, { desc = 'Go to next info' })
vim.keymap.set({ 'n' }, '[3', function()
  vim.diagnostic.goto_prev { severity = 3 }
end, { desc = 'Go to previous info' })

vim.keymap.set({ 'n' }, ']4', function()
  vim.diagnostic.goto_next { severity = 4 }
end, { desc = 'Go to next hint' })
vim.keymap.set({ 'n' }, '[4', function()
  vim.diagnostic.goto_prev { severity = 4 }
end, { desc = 'Go to previous hint' })

-- Keymaps for moving lines around
vim.keymap.set('v', 'Ô', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'Ô', 'V')
vim.keymap.set('n', '', 'V')

-- Switch header/source
vim.keymap.set({ 'n', 'i', 'x', 'v' }, 'ø', '<cmd>Ouroboros<CR>', { desc = 'Switch header/source' })
vim.keymap.set({ 'n', 'i', 'x', 'v' }, 'Ø', '<cmd>ClangdSwitchSourceHeader<CR>', { desc = 'Switch header/source (heavy)' })

--- HACK: Override `vim.lsp.util.stylize_markdown` to use Treesitter.
-- <https://github.com/hrsh7th/nvim-cmp/issues/1699#issuecomment-1738132283>
---@param bufnr integer
---@param contents string[]
---@param opts table
---@return string[]
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.util.stylize_markdown = function(bufnr, contents, opts)
  contents = vim.lsp.util._normalize_markdown(contents, {
    width = vim.lsp.util._make_floating_popup_size(contents, opts),
  })
  vim.bo[bufnr].filetype = 'markdown'
  vim.treesitter.start(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, contents)

  return contents
end

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('isaac-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 150 }
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'chrisgrieser/nvim-spider', lazy = true },

  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup()
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '󰍵' },
        topdelete = { text = '‾' },
        changedelete = { text = '│' },
        untracked = { text = '│' },
      },
    },
  },

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      -- TODO: Put this in proper place
      -- This will disable bold for current line number
      vim.cmd 'hi CursorLineNr cterm=NONE gui=NONE'
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-tree/nvim-web-devicons',
        opts = function()
          return { override = require 'dev_icons' }
        end,
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '-L',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          prompt_prefix = '   ',
          selection_caret = '  ',
          entry_prefix = '  ',
          initial_mode = 'insert',
          selection_strategy = 'reset',
          sorting_strategy = 'ascending',
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.40,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.97,
            height = 0.90,
            preview_cutoff = 120,
          },
          file_sorter = require('telescope.sorters').get_fuzzy_file,
          file_ignore_patterns = { 'node_modules' },
          generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
          path_display = { 'truncate' },
          winblend = 0,
          border = {},
          borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
          file_previewer = require('telescope.previewers').vim_buffer_cat.new,
          grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
          qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
          mappings = {
            n = {
              ['q'] = require('telescope.actions').close,
              ['<Tab>'] = require('telescope.actions').move_selection_next,
              ['<S-Tab>'] = require('telescope.actions').move_selection_previous,
              ['å'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_next,
            },
            i = {
              ['<Tab>'] = require('telescope.actions').move_selection_next,
              ['<S-Tab>'] = require('telescope.actions').move_selection_previous,
              ['å'] = require('telescope.actions').toggle_selection + require('telescope.actions').move_selection_next,
              [',1'] = function(bufnr)
                require('telescope.actions').close(bufnr)
                vim.cmd 'Telescope diagnostics severity=1'
              end,
              [',2'] = function(bufnr)
                require('telescope.actions').close(bufnr)
                vim.cmd 'Telescope diagnostics severity=2'
              end,
              [',3'] = function(bufnr)
                require('telescope.actions').close(bufnr)
                vim.cmd 'Telescope diagnostics severity=3'
              end,
              [',4'] = function(bufnr)
                require('telescope.actions').close(bufnr)
                vim.cmd 'Telescope diagnostics severity=4'
              end,
            },
          },
        },

        extensions_list = {},
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- Dashboard plugin I'm using
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      -- Set header
      dashboard.section.header.val = {
        '',
        '',
        '',
        '',
        '',
        '',
        --
        -- '                                                     ',
        -- '           ███╗   ██╗██╗   ██╗██╗███╗   ███╗         ',
        -- '           ████╗  ██║██║   ██║██║████╗ ████║         ',
        -- '           ██╔██╗ ██║██║   ██║██║██╔████╔██║         ',
        -- '           ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║         ',
        -- '           ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║         ',
        -- '           ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝         ',
        -- '                                                     ',

        -- '                                                     ',
        -- '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
        -- '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
        -- '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
        -- '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
        -- '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
        -- '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
        -- '                                                     ',

        [[     /\__\         /\__\          ___        /\__\     ]],
        [[    /::|  |       /:/  /         /\  \      /::|  |    ]],
        [[   /:|:|  |      /:/  /          \:\  \    /:|:|  |    ]],
        [[  /:/|:|  |__   /:/__/  ___      /::\__\  /:/|:|__|__  ]],
        [[ /:/ |:| /\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\ ]],
        [[ \/__|:|/:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  / ]],
        [[     |:/:/  /   |:|__/:/  /  \::/__/           /:/  /  ]],
        [[     |::/  /     \::::/__/    \:\__\          /:/  /   ]],
        [[     /:/  /       ~~~~         \/__/         /:/  /    ]],
        [[     \/__/                                   \/__/     ]],
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button('e', '  - New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('f', '󰮗  - Find file', ':Telescope find_files<CR>'),
        dashboard.button('r', '  - Recent', ':Telescope oldfiles<CR>'),
        dashboard.button('s', '  - Settings', ':e $MYVIMRC<CR>'),
        dashboard.button('q', '󰿅  - Quit NVIM', ':qa<CR>'),
      }

      require('alpha').setup(dashboard.opts)
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          local present, null_ls = pcall(require, 'null-ls')

          if not present then
            return
          end

          local b = null_ls.builtins
          local h = require 'null-ls.helpers'

          local sources = {

            -- webdev stuff
            b.formatting.deno_fmt,
            b.formatting.prettier.with { filetypes = { 'html', 'markdown', 'css' } },

            -- Lua
            b.formatting.stylua,

            -- cpp
            b.formatting.clang_format.with { extra_args = { '-style=Chromium' } },

            b.formatting.gofumpt,
            b.formatting.goimports_reviser,
          }

          null_ls.setup {
            debug = true,
            sources = sources,
          }
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('isaac-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>gT', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>S', require('telescope.builtin').lsp_document_symbols, 'Document [S]ymbols')
          map('<leader>ra', vim.lsp.buf.rename, '[R]en[a]me')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('isaac-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('isaac-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'isaac-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>ti', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle [I]nlay Hints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {
          cmd = {
            'clangd',
            '--offset-encoding=utf-8',
          },
        },

        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  ignore = { 'W391', 'E302', 'E501', 'E402', 'W293' },
                  maxLineLength = 100,
                },
              },
            },
          },
        },

        ['rust-analyzer'] = {
          settings = {
            cargo = {
              -- Add clippy lints for Rust.
              allFeatures = true,
            },
            procMacro = {
              enable = true,
            },
            checkOnSave = {
              allFeatures = true,
              command = 'clippy',
              extraArgs = {
                '--',
                '--no-deps',
              },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        gopls = {},

        jdtls = {
          root_dir = function()
            local java_root_patterns = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
            return vim.fs.dirname(vim.fs.find(java_root_patterns, { upward = true })[1]) or vim.fn.getcwd()
          end,
        },
      }

      require('mason').setup {
        PATH = 'skip',
        max_concurrent_installers = 10,
        ui = {
          icons = {
            package_pending = ' ',
            package_installed = '󰄳 ',
            package_uninstalled = ' 󰚌',
          },

          keymaps = {
            toggle_server_expand = '<CR>',
            install_server = 'i',
            update_server = 'u',
            check_server_version = 'c',
            update_all_servers = 'U',
            check_outdated_servers = 'C',
            uninstall_server = 'X',
            cancel_installation = '<C-c>',
          },
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        -- Used to format Lua code
        'stylua',

        -- lua stuff
        'lua-language-server',
        'stylua',

        -- web dev stuff
        'css-lsp',
        'html-lsp',
        'typescript-language-server',
        'deno',
        'prettier',

        -- c/cpp stuff
        'clangd',
        'clang-format',

        -- python stuff
        'python-lsp-server',

        -- rust
        'rust-analyzer',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { 'https://github.com/IsaacShelton/AdeptVim', lazy = false },

  {
    'jakemason/ouroboros',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    lazy = false,
  },

  {
    'luckasRanarison/clear-action.nvim',
    opts = {
      silent = true, -- dismiss code action requests errors
      signs = {
        enable = false,
        combine = false, -- combines all action kinds into a single sign
        priority = 200, -- extmark priority
        position = 'eol', -- "right_align" | "overlay"
        separator = ' ', -- signs separator
        show_count = false, -- show the number of each action kind
        show_label = false, -- show the string returned by `label_fmt`
        label_fmt = function(actions)
          return actions[1].title
        end, -- actions is an array of `CodeAction`
        update_on_insert = false, -- show and update signs in insert mode
        icons = {
          quickfix = '🔧',
          refactor = '💡',
          source = '🔗',
          combined = '💡', -- used when combine is set to true or as a fallback when there is no action kind
        },
        highlights = { -- highlight groups
          quickfix = 'NonText',
          refactor = 'NonText',
          source = 'NonText',
          combined = 'NonText',
          label = 'NonText',
        },
      },
      popup = { -- replaces the default prompt when selecting code actions
        enable = false,
        center = false,
        border = 'rounded',
        hide_cursor = false,
        hide_client = false, -- hide displaying name of LSP client
        highlights = {
          header = 'CodeActionHeader',
          label = 'CodeActionLabel',
          title = 'CodeActionTitle',
        },
      },
      mappings = {
        -- The values can either be a string or a string tuple (with description)
        -- example: "<leader>aq" | { "<leader>aq", "Quickfix" }
        -- Or if you want more control: { key = "<leader>aq", mode = { "n" }, options = { desc = "Quickfix" } }
        -- `options` accetps the same keys as vim.keymap.set()
        code_action = nil, -- a modified version of `vim.lsp.buf.code_action`
        apply_first = nil, -- directly applies the first code action
        -- These are just basically `vim.lsp.buf.code_action` with the `apply` option with some filters
        -- If there's only one code action, it gets automatically applied.
        quickfix = nil, -- can be filtered with the `quickfix_filter` option bellow
        quickfix_next = nil, -- tries to fix the next diagnostic
        quickfix_prev = nil, -- tries to fix the previous diagnostic
        refactor = nil,
        refactor_inline = nil,
        refactor_extract = nil,
        refactor_rewrite = nil,
        source = nil,
        -- server-specific mappings, server_name = {...}
        -- This is a map of code actions prefixes and keys
        actions = {
          -- example:
          ['rust_analyzer'] = {
            ['Import'] = '<leader>m',
            ['Fill match arms'] = '<leader>F',
            ['Fill struct fields'] = '<leader>G',
          },
        },
      },
      -- This is used for filtering actions in the quickfix functions
      -- It's a map of diagnostic codes and the preferred action prefixes
      -- You can check the diagnostic codes by hovering on the diagnostic
      quickfix_filters = {
        -- example:
        -- ["rust_analyzer"] = {
        --   ["E0433"] = "Import",
        -- },
        -- ["lua_ls"] = {
        --   ["unused-local"] = "Disable diagnostics on this line",
        -- },
      },
      action_labels = {
        -- example:
        -- ["dartls"] = {
        --   "Wrap with widget..." = "w",
        --   "Wrap with Padding" = "p",
        --   "Wrap with Center" = "c",
        -- },
      },
    },
    lazy = false,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    lazy = false,
    opts = {
      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@conditional.outer',
            ['ic'] = '@conditional.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['aC'] = '@class.outer',

            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            -- ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            -- You can also use captures from other query groups like `locals.scm`
            -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true or false
          include_surrounding_whitespace = true,
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'nvimtools/none-ls.nvim',
    ft = 'go',
  },

  { 'IsaacShelton/cmp-nvim-lsp-signature-help' },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      --
      local field_arrangement = {
        atom = { 'kind', 'abbr', 'menu' },
        atom_colored = { 'kind', 'abbr', 'menu' },
      }

      local cmp_style = 'atom_colored'
      local use_icons = true
      local lspkind_text = true

      local formatting_style = {
        -- default fields order i.e completion word + item.kind + item.kind icons
        fields = field_arrangement[cmp_style] or { 'abbr', 'kind', 'menu' },

        format = function(_, item)
          local icons = require 'lspkind_icons'
          local icon = (use_icons and icons[item.kind]) or ''

          if cmp_style == 'atom' or cmp_style == 'atom_colored' then
            icon = ' ' .. icon .. ' '
            item.menu = lspkind_text and '   (' .. item.kind .. ')' or ''
            item.kind = icon
          else
            icon = lspkind_text and (' ' .. icon .. ' ') or icon
            item.kind = string.format('%s %s', icon, lspkind_text and item.kind or '')
          end

          return item
        end,
      }

      -- Highlight customizations
      local c = require('nord.colors').palette

      local highlights = {
        CmpItemAbbrDeprecated = { fg = c.polar_night.light },
        CmpItemAbbrMatch = { fg = c.frost.ice, bold = true },
        CmpItemAbbrMatchFuzzy = { fg = c.frost.ice, bold = true },
        CmpItemKind = { bg = c.frost.artic_water },
        CmpItemKindVariable = { bg = c.frost.ice },
        CmpItemKindInterface = { bg = c.frost.ice },
        CmpItemKindClass = { bg = c.frost.ice },
        CmpItemKindFunction = { bg = c.aurora.purple },
        CmpItemKindMethod = { bg = c.aurora.purple },
        CmpItemKindSnippet = { bg = c.aurora.green },
        CmpItemKindText = { bg = c.snow_storm.bright },

        CodeiumSuggestion = { fg = c.polar_night.light },
      }

      -- Highlight customizations
      vim.api.nvim_set_hl(0, 'CmpSel', { bg = c.polar_night.brightest, fg = 'NONE' })
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#282f34', fg = 'NONE' })
      vim.api.nvim_set_hl(0, 'Pmenu', { fg = '#C5CDD9', bg = '#22252A' })

      for name, highlight in pairs(highlights) do
        vim.api.nvim_set_hl(0, name, highlight)
      end

      cmp.setup {
        window = {
          completion = {
            winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel',
            col_offset = -3,
            scrollbar = false,
            side_padding = 0,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            -- Custom comparator to prioritize fields
            -- Returns true if first should be ranked higher
            -- PREFER FIELDS
            function(a, b)
              local FIELD = 5
              if a:get_kind() == FIELD and b:get_kind() ~= FIELD then
                return true
              elseif a:get_kind() ~= FIELD and b:get_kind() == FIELD then
                return false
              else
                return nil
              end
            end,

            -- DISPREFER SNIPPETS
            function(a, b)
              local SNIPPET = 15
              if a:get_kind() == SNIPPET and b:get_kind() ~= SNIPPET then
                return false
              elseif a:get_kind() ~= SNIPPET and b:get_kind() == SNIPPET then
                return true
              else
                return nil
              end
            end,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            -- compare.scopes, (disabled by default)
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            -- compare.sort_text, (disabled by default)
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        preselect = cmp.PreselectMode.None,
        formatting = formatting_style,
        mapping = {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-l>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
            else
              fallback()
            end
          end, {
            'i',
            's',
          }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
            else
              fallback()
            end
          end, {
            'i',
            's',
          }),
        },

        sources = {
          { name = 'nvim_lsp', priority = 10 },
          { name = 'path', priority = 2 },
          { name = 'buffer', priority = 4 },
          { name = 'luasnip', priority = 3 },
          { name = 'nvim_lsp_signature_help', priority = 2 },
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
        },
      }
    end,
  },

  -- The colorscheme I use
  {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'nord'
      require('nord').load()
    end,
    opts = {
      install = { colorscheme = 'nord' },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim

      diff = { mode = 'bg' }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
      borders = true, -- Enable the border between verticaly split windows visible

      errors = { mode = 'bg' }, -- Display mode for errors and diagnostics
      -- values : [bg|fg|none]
      --
      search = { theme = 'vim' }, -- theme for highlighting search results
      -- values : [vim|vscode]
      --
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = {},
        functions = {},
        variables = {},

        -- To customize lualine/bufferline
        bufferline = {
          current = {},
          modified = { italic = true },
        },
      },
    },
  },

  -- Plugin for light theme alternative
  {
    {
      'Shatur/neovim-ayu',
      dependencies = { 'gbprod/nord.nvim' },
      options = {
        theme = 'ayu-light',
      },
      config = function(_, opts)
        require('ayu').setup(opts)
      end,
    },
  },

  -- Plugin for deleting buffers without the windows they occupy
  {
    'famiu/bufdelete.nvim',
    opts = {},
    config = function()
      -- Allow for <leader>x to close current buffer
      vim.keymap.set('n', '<leader>x', function()
        require('bufdelete').bufdelete(0)
      end, { desc = 'Close current buffer' })
    end,
  },

  -- My bufferline plugin I like
  {
    'akinsho/bufferline.nvim',
    version = '4.7.0',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'gbprod/nord.nvim' },
    opts = {
      options = {
        separator_style = 'thin',
        offsets = {
          {
            filetype = 'NvimTree',
          },
        },
        always_show_bufferline = false,
        auto_toggle_bufferline = true,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
    end,
  },

  -- My statusline plugin I'm using
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'archibate/lualine-time' },
    opts = {
      theme = 'nord',
      extensions = {},
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {},
      options = {
        always_divide_middle = true,
        component_separators = {
          left = '|', -- ',
          right = '|', -- ',
        },
        --[[
        disabled_filetypes = {
          'statusline',
          'winbar',
          'NvimTree',
        },
        ]]
        globalstatus = true,
        icons_enabled = true,
        -- ignore_focus = {},
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
        section_separators = {
          left = '',
          right = '',
        },
        theme = 'auto',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'filename' },
        lualine_x = {
          {
            'diagnostics',
            symbols = {
              error = symbols.ERROR .. ' ',
              warn = symbols.WARN .. ' ',
              info = symbols.INFO .. ' ',
              hint = symbols.HINT .. ' ',
            },
          },
          'filetype',
        },
        lualine_y = {
          {
            function()
              local ruler = ''
              local icon = ' '

              local current_line = vim.fn.line '.'
              local total_line = vim.fn.line '$'

              local text = math.modf((current_line / total_line) * 100) .. '%%'
              text = string.format('%4s', text)

              text = (current_line == 1 and 'Top') or text
              text = (current_line == total_line and 'Bot') or text

              local column = string.format('%02s', vim.fn.col '.')

              return ruler .. ' ' .. column .. ' ' .. icon .. text
            end,
          },
        },
        lualine_z = {
          {
            function()
              local clock = ' '
              return clock .. os.date '%I:%M' .. ' '
            end,
          },
        },
      },
      tabline = {},
      winbar = {},
    },
  },

  -- My commenting plugin I like
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gcc', mode = 'n' },
      { 'gc', mode = 'v' },
      { 'gbc', mode = 'n' },
      { 'gb', mode = 'v' },
    },
    init = function()
      vim.keymap.set('n', '<leader>/', function()
        require('Comment.api').toggle.linewise.current()
      end, { desc = 'Toggle comment (in normal mode)' })

      vim.keymap.set(
        'v',
        '<leader>/',
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        { desc = 'Toggle comment (in visual mode)' }
      )
    end,
    config = function(_, opts)
      require('Comment').setup(opts)
    end,
  },

  -- Tree plugin I'm using
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
    init = function()
      vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle tree view' })
    end,
    opts = {
      filters = {
        git_ignored = true,
      },
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      view = {
        adaptive_size = false, -- Can be true to auto-expand horizontally
        side = 'left',
        width = 30,
        preserve_window_proportions = true,
      },
      git = {
        enable = true,
        ignore = false,
      },
      filesystem_watchers = {
        enable = true,
      },
      actions = {
        open_file = {
          resize_window = true,
        },
      },
      renderer = {
        root_folder_label = false,
        highlight_git = true,
        highlight_opened_files = 'none',
        indent_markers = {
          enable = false,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
            git = false,
          },

          glyphs = {
            default = '󰈚',
            symlink = '',
            folder = {
              default = '',
              empty = '',
              empty_open = '',
              open = '',
              symlink = '',
              symlink_open = '',
              arrow_open = '',
              arrow_closed = '',
            },
            git = {
              unstaged = '✗',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '◌',
            },
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },

  {
    'echasnovski/mini.nvim',
    recommended = true,
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'gsa', -- Add surrounding in Normal and Visual modes
          delete = 'gsd', -- Delete surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding
          update_n_lines = 'gsn', -- Update `n_lines`
        },
      }
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'css',
        'javascript',
        'typescript',
        'tsx',
        'rust',
      },
      auto_install = true, -- Autoinstall languages that are not installed
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  require 'plugins.autopairs',
  require 'plugins.gitsigns',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- Helper functions for enabling/disable autopairs
function enable_autopairs()
  require('nvim-autopairs').enable()
end

function disable_autopairs()
  require('nvim-autopairs').disable()
end
