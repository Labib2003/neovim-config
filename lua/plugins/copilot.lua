return {
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
}
