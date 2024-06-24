-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {
  -- == Examples of Overriding Plugins ==

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "github/copilot.vim",
    config = function()
      -- Disable the default <Tab> key mapping
      vim.g.copilot_no_tab_map = true

      -- Map '<C-a>' to accept the Copilot suggestion
      vim.keymap.set("i", "<C-a>", 'copilot#Accept("")', { expr = true, silent = true, replace_keycodes = false })

      -- Map '<C-;>' to cycle to the next suggestion
      vim.keymap.set("i", "<C-;>", "<Plug>(copilot-next)", { silent = true })

      -- Map '<C-,>' to cycle to the previous suggestion
      vim.keymap.set("i", "<C-,>", "<Plug>(copilot-previous)", { silent = true })

      -- Map '<C-x>' to dismiss the suggestion
      vim.keymap.set("i", "<C-x>", "<Plug>(copilot-dismiss)", { silent = true })

      -- Map '<C-s>' to search with Copilot (if applicable)
      vim.keymap.set("i", "<C-s>", function() return vim.fn["copilot#Search"]() end, { expr = true, silent = true })
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
}
