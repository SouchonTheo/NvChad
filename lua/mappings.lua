require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>lf", function()
  require("conform").format()
end, { desc = "File Format with conform" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- split horizontal
map("n", "<F2>", "<cmd>split<CR>", { desc = "Split horizontal" })
-- split vertical
map("n", "<F3>", "<cmd>vsplit<CR>", { desc = "Split vertical" })

map("n", "<leader>lc", "<cmd>Fidget clear<CR>", { desc = "Clear lsp logs" })

-- Lsp section
-- Lsp info
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "Lsp Info" })

