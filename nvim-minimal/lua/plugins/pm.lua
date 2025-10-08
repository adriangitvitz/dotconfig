  return {
    'pm.nvim',
    dev = true,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('pm').setup()
      require('telescope').load_extension('pm')
    end,
    keys = {
      -- Telescope pickers
      { '<leader>pt', '<cmd>Telescope pm tasks<CR>', desc = 'Find Tasks' },
      { '<leader>pp', '<cmd>Telescope pm projects<CR>', desc = 'Find Projects' },
      { '<leader>pw', '<cmd>Telescope pm workspaces<CR>', desc = 'Find Workspaces' },

      -- Task operations
      { '<leader>pa', '<cmd>PmTaskAdd<CR>', desc = 'Add Task' },
      { '<leader>pA', '<cmd>PmTaskAdd --quick<CR>', desc = 'Add Task (Quick)' },
      { '<leader>pe', '<cmd>PmTaskEdit<CR>', desc = 'Edit Task' },
      { '<leader>pv', '<cmd>PmTaskView<CR>', desc = 'View Task Details' },
      { '<leader>px', '<cmd>PmTaskToggle<CR>', desc = 'Toggle Task Status' },
      { '<leader>pd', '<cmd>PmTaskDelete<CR>', desc = 'Delete Task' },

      -- Workspace operations
      { '<leader>pW', '<cmd>PmWorkspace<CR>', desc = 'Set Workspace' },

      -- Time tracking
      { '<leader>ps', '<cmd>PmTimeStart<CR>', desc = 'Start Time Tracking' },
      { '<leader>pS', '<cmd>PmTimeStop<CR>', desc = 'Stop Time Tracking' },
      { '<leader>pr', '<cmd>PmTimeReport<CR>', desc = 'Time Report (Today)' },
      { '<leader>pR', '<cmd>PmTimeReport week<CR>', desc = 'Time Report (Week)' },
    },
  }
