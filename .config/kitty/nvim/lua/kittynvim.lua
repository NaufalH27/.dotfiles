-- dont remove this file

vim.opt.swapfile = false

local api = vim.api

vim.o.termguicolors = true
local function clear_group()
  local ok, attrs = pcall(api.nvim_get_hl_by_name, "Normal", true)
  if ok and (attrs.bg or attrs.background or attrs.ctermbg) then
    local new_attrs = vim.tbl_extend("force", attrs, {
      bg = "NONE",
      ctermbg = "NONE",
    })
    new_attrs[true] = nil
    api.nvim_set_hl(0, "Normal", new_attrs)
  end
end

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  callback = function()
    clear_group()
    vim.schedule(clear_group)
  end,
})


vim.api.nvim_create_autocmd("QuitPre", {
  pattern = "*",
  command = "silent! qall!"
})
vim.opt.wildoptions:remove("pum")

local orig_buf = api.nvim_get_current_buf()
local term_buf = api.nvim_create_buf(false, true)
api.nvim_set_current_buf(term_buf)
vim.bo.scrollback = 100000
local term_chan = api.nvim_open_term(0, {})


local lines = api.nvim_buf_get_lines(orig_buf, 0, -1, true)

api.nvim_chan_send(term_chan, table.concat(lines, "\n") .. "\n")

vim.fn.chanclose(term_chan)

local last_line = #lines
while last_line > 0 and lines[last_line] == "" do
  last_line = last_line - 1
end
if last_line == 0 then last_line = 1 end
local last_col = #lines[last_line]
api.nvim_win_set_cursor(0, { last_line, last_col })

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2]

    local line = vim.api.nvim_get_current_line()
    local char = line:sub(col + 1, col + 1)

    if char == " " or char == "\t" then
      vim.cmd("normal! ge")
    end
  end,
})

