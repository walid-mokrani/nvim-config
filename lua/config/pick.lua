-- Returns a function that runs a telescope.builtin picker. Telescope is only
-- required when the function is called, so mapping keys to it keeps Telescope
-- lazy-loaded. `opts` may be a table or a function returning one (for options
-- that themselves require Telescope modules).
---@param picker string telescope.builtin picker name
---@param opts? table|fun(): table
---@return fun()
return function(picker, opts)
  return function()
    require('telescope.builtin')[picker](type(opts) == 'function' and opts() or opts)
  end
end
