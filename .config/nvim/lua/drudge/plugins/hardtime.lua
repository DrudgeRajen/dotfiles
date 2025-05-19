return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    require("hardtime").setup({
      disabled_filetypes = { "NvimTree", "lazy", "mason", "trouble" },
      disable_mouse = false,
      max_time = 5000,
    })
  end
}
