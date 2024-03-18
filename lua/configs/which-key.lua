local wk = require("which-key")

wk.register({
  g = {
    name = "Git",
    -- s = { "<cmd>Git status<cr>", "Status" },
    -- p = { "<cmd>Git push<cr>", "Push" },
    -- c = { "<cmd>Git commit<cr>", "Commit" },
    -- Ajoutez d'autres sous-commandes ici
  },
  f = {
    name = "File",
    -- s = { "<cmd>Telescope find_files<cr>", "Find" },
    -- e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    -- Ajoutez d'autres sous-commandes ici
  },
  l = {
    name = "LSP",
    -- d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
    -- r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
    -- Ajoutez d'autres sous-commandes ici
  },
}, { prefix = "<leader>" })
