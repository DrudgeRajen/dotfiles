-- use nvim-tree instead of netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "

-- replace selected text without clipboard or any register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Move seleted line up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without affecting register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Moving in location list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Toggle Tagbar
vim.keymap.set("n", "<C-K><C-T>", ":TagbarToggle<CR>", { silent = true })

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Re-align split screens" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close selected split" })

-- clear quickfix list
vim.keymap.set('n', '<leader>cq', function()
  vim.fn.setqflist({})
end, { desc = "Clear quickfix list" })

-- error window
vim.keymap.set("n", "<leader>e", function()
  vim.diagnostic.open_float()
end, { desc = "Show error on float" })

-- spectre related mappings
vim.keymap.set('n', '<leader>s', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = "Toggle Spectre"
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = "Search current word"
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = "Search current word"
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = "Search on current file"
})
