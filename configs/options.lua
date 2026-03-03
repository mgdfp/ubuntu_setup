-- Disable LazyVim's strict import order check
vim.g.lazyvim_check_order = false

-- Set the Python host to our isolated venv
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/venv/bin/python")
