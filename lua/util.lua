local M = {}

---@param keys string
---@param func function | string
---@param desc? string
---@param mode? string | string[]
---@param bufnr? integer
M.map = function (keys, func, desc, mode, bufnr)
  mode = mode or 'n'
  vim.keymap.set (mode, keys, func, { desc = desc, buffer = bufnr })
end

return M
