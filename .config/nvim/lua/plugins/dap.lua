return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI for debugging
      "jay-babu/mason-nvim-dap.nvim", -- Install debuggers
      "mfussenegger/nvim-dap-python", -- Python debugging
      "theHamsta/nvim-dap-virtual-text", -- Inline debug info
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
    require('dap-go').setup {
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
      delve = {
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = {},
        detached = vim.fn.has("win32") == 0,
        cwd = nil,
      },
      tests = {
        verbose = false,
      },
    }
        vim.keymap.set("n", "<C-S-d>", function() dap.continue() end, { desc = "Start/Continue Debugging" })
        vim.keymap.set("n", "<C-S-o>", function() dap.step_over() end, { desc = "Step Over" })
        vim.keymap.set("n", "<C-S-i>", function() dap.step_into() end, { desc = "Step Into" })
        vim.keymap.set("n", "<C-S-u>", function() dap.step_out() end, { desc = "Step Out" })
        vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
        vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Set Conditional Breakpoint" })
        vim.keymap.set("n", "<Leader>dr", function() dap.repl.open() end, { desc = "Open Debug REPL" })
        vim.keymap.set("n", "<Leader>du", function() dapui.open() end, { desc = "Open DAP UI" })
        vim.keymap.set("n", "<Leader>dd", function() dapui.close() end, { desc = "Close DAP UI" })
        vim.keymap.set("n", "<Leader>dl", function() dap.repl.toggle() end, { desc = "Toggle DAP Log" })
        vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "Error", linehl = "", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "Warning", linehl = "", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "🟢", texthl = "Info", linehl = "", numhl = "" })
    end,
  },
}

