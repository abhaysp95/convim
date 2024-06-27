-- temporary placement here
local words = {}
for word in string.gmatch(vim.api.nvim_exec("!uname -a", true), "%S+") do
  words[#words + 1] = word
end
-- exporte globally to be used in different modules
Architecture = words[#words - 1].." "..words[#words]

require ("user.launch")
require ("user.options")
require ("user.keymaps")
require ("user.autocmds")
require ("user.plugin_keybindings")
spec ("user.colorscheme")
spec ("user.norg")
spec ("user.devicons")
spec ("user.treesitter")
spec ("user.schemastore")
if Architecture ~= "aarch64 Android" then
  spec ("user.mason")
  spec ("user.lspconfig")
end
spec ("user.cmp")
-- spec ("user.whichkey")
spec ("user.none-ls")
spec ("user.telescope")
spec ("user.nvimtree")
spec ("user.comment")
spec ("user.lualine")
spec ("user.tmuxnavigator")
spec ("user.navic")
spec ("user.breadcrumbs")
spec ("user.harpoon")
spec ("user.illuminate")
spec ("user.toggleterm")
spec ("user.gitsigns")
spec ("user.neogit")
spec ("user.autopairs")
spec ("user.project")
spec ("user.trouble")
spec ("user.undotree")
spec ("user.extras.tabby")
spec ("user.extras.neoscroll")
spec ("user.extras.oil")
spec ("user.extras.ufo")
spec ("user.extras.gitlinker")
spec ("user.extras.bqf")
spec ("user.extras.dressing") -- doesn't allow me to use Ctrl-F like I do in command mode
spec ("user.extras.colorizer")
spec ("user.extras.fidget")
spec ("user.extras.navbuddy")
spec ("user.extras.modicator")
require ("user.lazy")

if vim.g.neovide then
  vim.o.guifont = "Operator Mono Lig:h10" -- text below applies for VimScript
  print("neovide done")
end
