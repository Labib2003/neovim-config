return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    -- You can modify plugin options here if needed
  end,
  config = function(_, opts)
    require("aerial").setup(opts)

    -- Set the Enter key mapping in aerial buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "aerial",
      callback = function()
        vim.keymap.set(
          "n",
          "<CR>",
          "<cmd>lua require'aerial'.select()<CR><cmd>AerialClose<CR>",
          { buffer = true, noremap = true, silent = true }
        )
      end,
    })
  end,
}
