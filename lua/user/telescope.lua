local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
    "MunifTanjim/nui.nvim"
  },
}

function M.config()

  local Layout = require("nui.layout")
  local Popup = require("nui.popup")

  local telescope = require("telescope")
  local TSLayout = require("telescope.pickers.layout")

  local function make_popup(options)
    local popup = Popup(options)
    function popup.border:change_title(title)
      popup.border.set_text(popup.border, "top", title)
    end
    return TSLayout.Window(popup)
  end

  local icons = require "user.icons"
  local actions = require "telescope.actions"


  telescope.setup {
    defaults = {
      layout_strategy = "flex",
      layout_config = {
        horizontal = {
          size = {
            width = "90%",
            height = "75%",
          },
        },
        vertical = {
          size = {
            width = "90%",
            height = "90%",
          },
        },
      },
      create_layout = function(picker)
        local border = {
          results = {
            top_left = "┌",
            top = "─",
            top_right = "┬",
            right = "│",
            bottom_right = "",
            bottom = "",
            bottom_left = "",
            left = "│",
          },
          results_patch = {
            minimal = {
              top_left = "┌",
              top_right = "┐",
            },
            horizontal = {
              top_left = "┌",
              top_right = "┬",
            },
            vertical = {
              top_left = "├",
              top_right = "┤",
            },
          },
          prompt = {
            top_left = "├",
            top = "─",
            top_right = "┤",
            right = "│",
            bottom_right = "┘",
            bottom = "─",
            bottom_left = "└",
            left = "│",
          },
          prompt_patch = {
            minimal = {
              bottom_right = "┘",
            },
            horizontal = {
              bottom_right = "┴",
            },
            vertical = {
              bottom_right = "┘",
            },
          },
          preview = {
            top_left = "┌",
            top = "─",
            top_right = "┐",
            right = "│",
            bottom_right = "┘",
            bottom = "─",
            bottom_left = "└",
            left = "│",
          },
          preview_patch = {
            minimal = {},
            horizontal = {
              bottom = "─",
              bottom_left = "",
              bottom_right = "┘",
              left = "",
              top_left = "",
            },
            vertical = {
              bottom = "",
              bottom_left = "",
              bottom_right = "",
              left = "│",
              top_left = "┌",
            },
          },
        }

        local results = make_popup({
          focusable = false,
          border = {
            style = border.results,
            text = {
              top = picker.results_title,
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal",
          },
        })

        local prompt = make_popup({
          enter = true,
          border = {
            style = border.prompt,
            text = {
              top = picker.prompt_title,
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal",
          },
        })

        local preview = make_popup({
          focusable = false,
          border = {
            style = border.preview,
            text = {
              top = picker.preview_title,
              top_align = "center",
            },
          },
        })

        local box_by_kind = {
          vertical = Layout.Box({
            Layout.Box(preview, { grow = 1 }),
            Layout.Box(results, { grow = 1 }),
            Layout.Box(prompt, { size = 3 }),
          }, { dir = "col" }),
          horizontal = Layout.Box({
            Layout.Box({
              Layout.Box(results, { grow = 1 }),
              Layout.Box(prompt, { size = 3 }),
            }, { dir = "col", size = "50%" }),
            Layout.Box(preview, { size = "50%" }),
          }, { dir = "row" }),
          minimal = Layout.Box({
            Layout.Box(results, { grow = 1 }),
            Layout.Box(prompt, { size = 3 }),
          }, { dir = "col" }),
        }

        local function get_box()
          local strategy = picker.layout_strategy
          if strategy == "vertical" or strategy == "horizontal" then
            return box_by_kind[strategy], strategy
          end

          local height, width = vim.o.lines, vim.o.columns
          local box_kind = "horizontal"
          if width < 100 then
            box_kind = "vertical"
            if height < 40 then
              box_kind = "minimal"
            end
          end
          return box_by_kind[box_kind], box_kind
        end

        local function prepare_layout_parts(layout, box_type)
          layout.results = results
          results.border:set_style(border.results_patch[box_type])

          layout.prompt = prompt
          prompt.border:set_style(border.prompt_patch[box_type])

          if box_type == "minimal" then
            layout.preview = nil
          else
            layout.preview = preview
            preview.border:set_style(border.preview_patch[box_type])
          end
        end

        local function get_layout_size(box_kind)
          return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
        end

        local box, box_kind = get_box()
        local layout = Layout({
          relative = "editor",
          position = "50%",
          size = get_layout_size(box_kind),
        }, box)

        layout.picker = picker
        prepare_layout_parts(layout, box_kind)

        local layout_update = layout.update
        function layout:update()
          local box, box_kind = get_box()
          prepare_layout_parts(layout, box_kind)
          layout_update(self, { size = get_layout_size(box_kind) }, box)
        end

        return TSLayout(layout)
      end,
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
        "--trim",
      },

      mappings = {
        i = {
          ["<C-k>"] = actions.cycle_history_next,
          ["<C-j>"] = actions.cycle_history_prev,

          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default,
          ["<C-x>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,

          ["<c-d>"] = actions.delete_buffer,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["n"] = actions.move_selection_next,
          ["p"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = "dropdown",
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        previewer = true,
        initial_mode = "insert",
      },

      buffers = {
        theme = "dropdown",
        previewer = true,
        initial_mode = "insert",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      },
    },
  }
end

return M
