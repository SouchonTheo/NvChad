local map = vim.keymap.set

return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "j-hui/fidget.nvim",
      opts = {},
    },
    {
      "mfussenegger/nvim-dap",
      config = function(self, opts)
        -- Debug settings if you're using nvim-dap
        local dap = require "dap"

        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
              runType = "runOrTestFile",
              --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
            },
          },
        }
      end,
    },
  },
  ft = { "scala", "sbt", "java" },
  opts = function()
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      ammoniteJvmProperties = {
        "-Xmx5G",
        "-Xms500M",
      },
      javaHome = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home",
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      enableSemanticHighlighting = false,
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to either "off" or "on"
    --
    -- "off" will enable LSP progress notifications by Metals and you'll need
    -- to ensure you have a plugin like fidget.nvim installed to handle them.
    --
    -- "on" will enable the custom Metals status extension and you *have* to have
    -- a have settings to capture this in your statusline or else you'll not see
    -- any messages from metals. There is more info in the help docs about this
    metals_config.init_options.statusBarProvider = "off"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.on_attach = function(client, bufnr)
      require("metals").setup_dap()

      -- LSP mappings
      map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Show Hover" })
      map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
      map("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
      map("n", "gs", vim.lsp.buf.document_symbol, { desc = "Document Symbol" })
      map("n", "gws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbol" })
      map("n", "<leader>cl", vim.lsp.codelens.run, { desc = "CodeLens" })
      map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "Signature Help" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

      map("n", "<leader>ws", function()
        require("metals").hover_worksheet()
      end, { desc = "Hover Worksheet" })

      -- all workspace diagnostics
      map("n", "<leader>aa", vim.diagnostic.setqflist, { desc = "All Diagnostics" })

      -- all workspace errors
      map("n", "<leader>ae", function()
        vim.diagnostic.setqflist { severity = "E" }
      end, { desc = "All Errors" })

      -- all workspace warnings
      map("n", "<leader>aw", function()
        vim.diagnostic.setqflist { severity = "W" }
      end, { desc = "All Warnings" })

      -- buffer diagnostics only
      map("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Buffer Diagnostics" })

      map("n", "[c", function()
        vim.diagnostic.goto_prev { wrap = false }
      end, { desc = "Previous Diagnostic" })

      map("n", "]c", function()
        vim.diagnostic.goto_next { wrap = false }
      end, { desc = "Next Diagnostic" })

      -- Example mappings for usage with nvim-dap. If you don't use that, you can
      -- skip these
      map("n", "<leader>dc", function()
        require("dap").continue()
      end, { desc = "Continue" })

      map("n", "<leader>dr", function()
        require("dap").repl.toggle()
      end, { desc = "REPL toggle" })

      map("n", "<leader>dK", function()
        require("dap.ui.widgets").hover()
      end, { desc = "Hover" })

      map("n", "<leader>dt", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Toggle Breakpoint" })

      map("n", "<leader>dso", function()
        require("dap").step_over()
      end, { desc = "Step Over" })

      map("n", "<leader>dsi", function()
        require("dap").step_into()
      end, { desc = "Step Into" })

      map("n", "<leader>dl", function()
        require("dap").run_last()
      end, { desc = "Run Last" })
    end

    return metals_config
  end,
  config = function(self, metals_config)
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
