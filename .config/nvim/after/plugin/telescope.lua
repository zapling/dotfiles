local rg_additional_args = function(args)
    return {'--hidden'}
end


require('telescope').setup {
  pickers = {
      live_grep = {
          additional_args = rg_additional_args
      },
      grep_string = {
          additional_args = rg_additional_args
      },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')

function FilesChangedComparedToMain()
    require'telescope.builtin'.find_files({
        find_command = {'git', 'diff', '--name-only', 'main'},
        prompt_title = 'Git files modified compared to main'
    })
end
