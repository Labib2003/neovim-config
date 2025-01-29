return {
  -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "Exafunction/codeium.nvim", -- add codeium as dependency
    "onsails/lspkind-nvim", -- for symbol icons
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    local lspkind = require "lspkind"

    -- modify the sources part of the options table
    opts.sources = cmp.config.sources {
      { name = "codeium", priority = 600 }, -- add codeium source
      { name = "nvim_lsp", priority = 500 },
      { name = "cmp-dap", priority = 400 },
      { name = "luasnip", priority = 300 },
      { name = "buffer", priority = 200 },
      { name = "path", priority = 100 },
    }

    -- add lspkind formatting with Codeium icon
    opts.formatting = {
      format = lspkind.cmp_format {
        mode = "symbol",
        maxwidth = 50,
        ellipsis_char = "...",
        symbol_map = { Codeium = "" }, -- set symbol for codeium
      },
    }
  end,
  config = function(_, opts)
    local cmp = require "cmp"

    -- setup cmp with the updated options
    cmp.setup(opts)

    -- make sure Codeium setup happens after cmp setup
    require("codeium").setup {}

    -- Function to toggle Codeium source
    local function toggle_codeium()
      -- get list of sources
      local sources = require("cmp").get_config().sources
      if not sources then return end

      -- linear search to find index
      local codeium_source = nil
      for i, source in ipairs(sources) do
        if source.name == "codeium" then
          codeium_source = i
          break
        end
      end

      -- add or remove from list
      if codeium_source then
        table.remove(sources, codeium_source)
      else
        table.insert(sources, { name = "codeium", priority = 600 })
      end

      -- restart cmp
      require("cmp").setup.buffer { sources = sources }
    end

    -- Create a custom command to toggle Codeium
    vim.api.nvim_create_user_command("CodeiumToggle", toggle_codeium, {})
  end,
}
