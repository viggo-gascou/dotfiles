local present, alpha = pcall(require, "alpha")

if not present then
  return
end

require("base46").load_highlight "alpha"

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = "right",
    hl = "AlphaButtons",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

-- Inspire by https://gist.githubusercontent.com/sRavioli/889392632a05f6c751cb1d7b8d61e2d8/raw/
local function footer()
  local date = os.date("  %d-%m-%Y ")
  local time = os.date("  %H:%M:%S ")
  local plugins = "  " .. #vim.tbl_keys(packer_plugins) .. " plugins "

  local v = vim.version()
  local version = "  v" .. v.major .. "." .. v.minor .. "." .. v.patch

  return date .. time .. plugins .. version
end



-- dynamic header padding
local fn = vim.fn
local marginTopPercent = 2
local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

local options = {

  -- Inspired by https://gist.githubusercontent.com/sRavioli/889392632a05f6c751cb1d7b8d61e2d8/raw/
  header = {
    type = "text",
    val = require("custom.tables.headers")["random"],
    -- val = require("custom.tables.headers").banners.sharp,
    opts = {
      position = "center",
      hl = "AlphaHeader",
    },
  },

--  header = {
--    type = "text",
--    val = {
--      "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
--      "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
--      "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
--      "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
--      "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
--      "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
--      "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
--      " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
--      " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
--      "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
--     "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
--    },
--    opts = {
--      position = "center",
--      hl = "AlphaHeader",
--    },
--  },

  buttons = {
    type = "group",
    val = {
      button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
      button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
      button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
      button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
      button("SPC t h", "  Themes  ", ":Telescope themes<CR>"),
      button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
    },
    opts = { spacing = 1 },
  },
  footer = {
    type = "text",
    val = footer(),
    opts = {
      position = "center",
      hl = "Constant", },
    }
  -- headerPaddingTop = { type = "padding", val = headerPadding },
  -- headerPaddingBottom = { type = "padding", val = 2 },

}

options = require("core.utils").load_override(options, "goolord/alpha-nvim")

local padd = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })

alpha.setup {
  layout = {
    { type = "padding", val = padd },
    options.header,
    { type = "padding", val = 1 },
    options.buttons,
    { type = "padding", val = 1 },
    options.footer,
  },
  opts = {},
}

-- alpha.setup {
--   layout = {
--     options.headerPaddingTop,
--     options.header,
--     options.headerPaddingBottom,
--     options.buttons,
--   },
--   opts = {},
-- }

-- Disable statusline in dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    -- store current statusline value and use that
    local old_laststatus = vim.opt.laststatus
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = old_laststatus
      end,
    })
    vim.opt.laststatus = 0
  end,
})
