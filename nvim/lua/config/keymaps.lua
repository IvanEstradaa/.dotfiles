vim.g.mapleader = ' '

local keymap = vim.keymap -- for conciseness

keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode with jk' })

keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- increment/decrement numbers
keymap.set('n', '<leader>+', '<C-a>', { desc = 'Increment number' })
keymap.set('n', '<leader>-', '<C-x>', { desc = 'Decrement number' })

-- window management
keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Split window vertically'})
keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Split window horizontally'})
keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size'})
keymap.set('n', '<leader>sx', '<cmd>close<CR>', { desc = 'Close current split'})

-- tab management
keymap.set('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab'})
keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab'})
keymap.set('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab'})
keymap.set('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab'})
keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab'})

-- move selected lines
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- dont move cursor when appending
keymap.set('n', 'J', 'mzJ`z')

-- keep cursor in the center when doing C-d C-u and searching
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')

-- keep cursor in the center when searching
keymap.set('n', 'n', 'nzzzv')
keymap.set('n', 'N', 'Nzzzv')

-- keep pasting the same element
keymap.set('x', '<leader>p', "\"_dP")

-- delete to void register, in order to not replace current clipboard
keymap.set('n', '<leader>d', "\"_d")
keymap.set('v', '<leader>d', "\"_d")

-- yank to system clipboard
keymap.set('n', '<leader>y', "\"+y")
keymap.set('v', '<leader>y', "\"+y")

-- replace current word
vim.keymap.set("n", "rc", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- automatically close brackets, parenthesis, and quotes
keymap.set("i", "'", "''<left>")
keymap.set("i", "\"", "\"\"<left>")
keymap.set("i", "(", "()<left>")
keymap.set("i", "{", "{}<left>")
keymap.set("i", "[", "[]<left>")
keymap.set("i", "/*", "/**/<left><left>")
keymap.set("i", '"', '""<left>')
