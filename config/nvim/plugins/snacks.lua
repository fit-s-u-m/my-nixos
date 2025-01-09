local snacks = require("snacks")
print("Snacks loaded")

snacks.setup({
  bigfile = { enabled = true },
  dashboard = {
      enabled = true,
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      preset = {
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
    },
  },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  quickfile = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

local function bind_key(key, func, desc)
  vim.keymap.set("n", key, func, { desc = desc })
end

bind_key("<leader>z", function() snacks.zen() end, "Toggle Zen Mode")
bind_key("<leader>Z", function() snacks.zen.zoom() end, "Toggle Zoom")
bind_key("<leader>.", function() snacks.scratch() end, "Toggle Scratch Buffer")
bind_key("<leader>S", function() snacks.scratch.select() end, "Select Scratch Buffer")
bind_key("<leader>n", function() snacks.notifier.show_history() end, "Notification History")
bind_key("<leader>bd", function() snacks.bufdelete() end, "Delete Buffer")
bind_key("<leader>cR", function() snacks.rename.rename_file() end, "Rename File")
bind_key("<leader>gB", function() snacks.gitbrowse() end, "Git Browse")
bind_key("<leader>gb", function() snacks.git.blame_line() end, "Git Blame Line")
bind_key("<leader>gf", function() snacks.lazygit.log_file() end, "Lazygit Current File History")
bind_key("<leader>gg", function() snacks.lazygit() end, "Lazygit")
bind_key("<leader>gl", function() snacks.lazygit.log() end, "Lazygit Log (cwd)")
bind_key("<leader>un", function() snacks.notifier.hide() end, "Dismiss All Notifications")
bind_key("<c-/>", function() snacks.terminal() end, "Toggle Terminal")
bind_key("<c-_>", function() snacks.terminal() end, "which_key_ignore")
bind_key("]]", function() snacks.words.jump(vim.v.count1) end, "Next Reference")
bind_key("[[", function() snacks.words.jump(-vim.v.count1) end, "Prev Reference")

bind_key("<leader>N", function()
  snacks.win({
    file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = "yes",
      statuscolumn = " ",
      conceallevel = 3,
    },
  })
end, "Neovim News")

-- Initialization for lazy-loaded functions
vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    _G.dd = function(...) snacks.debug.inspect(...) end
    _G.bt = function() snacks.debug.backtrace() end
    vim.print = _G.dd

    -- Toggle options mappings
    snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    snacks.toggle.diagnostics():map("<leader>ud")
    snacks.toggle.line_number():map("<leader>ul")
    snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
    snacks.toggle.treesitter():map("<leader>uT")
    snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    snacks.toggle.inlay_hints():map("<leader>uh")
    snacks.toggle.indent():map("<leader>ug")
    snacks.toggle.dim():map("<leader>uD")
  end,
})

