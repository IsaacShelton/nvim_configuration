return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  dependencies = { 'hrsh7th/nvim-cmp' },
  opts = {
    fast_wrap = {},
    disable_filetype = { 'TelescopePrompt', 'vim' },
  },
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'

    -- For automatically adding `(` after selecting a function or method
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
