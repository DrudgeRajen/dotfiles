return {
  "tpope/vim-fugitive",
  keys = {
    { "<leader>gs", "<cmd>Git<cr>",                     desc = "Git status" },
    { "<leader>gp", "<cmd>Git push -u origin HEAD<cr>", desc = "Git push" },
    { "<leader>gc", "<cmd>Git commit<cr>",              desc = "Git commit" },
    { "n",          "gu",                               "<cmd>diffget //2<CR>", desc = "Get diff from right side of merge tool" },
    { "n",          "gh",                               "<cmd>diffget //2<CR>", desc = "Get diff from left side of merge tool" },
  }
}
