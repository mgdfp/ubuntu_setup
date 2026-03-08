return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.window = opts.window or {}
    opts.window.mappings = opts.window.mappings or {}
    -- Make Neo-tree preview open in a split instead of a floating window
    opts.window.mappings["P"] = { "toggle_preview", config = { use_float = false } }
  end,
}
