local M = {}

local ft_cmds = {
	python = "python " .. vim.fn.fnameescape(vim.fn.expand('%')),
  sql = "psql " .. vim.fn.fnameescape(vim.fn.expand('%:p:h:t')) .. " -f " .. vim.fn.fnameescape(vim.fn.expand('%:t')),
}


-- tried to use the last line to make the command work for opening nvim in a directory above the file 
-- that was supposed to be executed but for some reason 'vim.fn.fnameescape(vim.fn.expand('%:t')'
-- results in an empty value :((
-- "cd " .. vim.fn.fnameescape(vim.fn.expand('%:p:h')) .. " && " .. 

M.general = {
	n = {
		["<C-b>"] = {
			function()

				require("nvterm.terminal").send(ft_cmds[vim.bo.filetype], "vertical")
			end,
			"execute file in terminal",
		},
	},
}

return M
