-- Get current git branch
-- Longer branch names gets cut off in smaller windows
local function GitBranchCutOff()
    local branch = vim.api.nvim_eval('fugitive#head()')
    local max_length = 29

    local win_width = vim.api.nvim_win_get_width(0)
    if win_width <= 53 then -- dont show branch when the window is small
        return ''
    elseif win_width < 90 then -- show short branch name
        max_length = 5
    end

    if string.len(branch) > max_length + 1 then
        return string.sub(branch, 0, max_length)..'~.'
    end

    return branch
end

require('lualine').setup{
  options = {
      theme = 'gruvbox',
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
  },
  sections = {
      lualine_b = {GitBranchCutOff},
  }
}
