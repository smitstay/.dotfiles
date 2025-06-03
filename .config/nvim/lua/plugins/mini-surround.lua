return {
  "echasnovski/mini.surround",
  version = "*",
  opts = {
    mappings = {
      add = "sa",            -- Add surround
      delete = "sd",         -- Delete surround
      replace = "sr",        -- Replace surround
      find = "sf",           -- Find surrounding text
      find_left = "sF",
      highlight = "sh",
      update_n_lines = "sn",
    },
    respect_selection_type = true, -- Avoid forcing insert mode
  }
}
