local function toggle_current_node(state)
  local node = state.tree:get_node()
  if node and node.type == "directory" then
    if node:is_expanded() then
      require("neo-tree.sources.filesystem.commands").close_all_subnodes(state, node)
    else
      require("neo-tree.sources.filesystem.commands").expand_all_nodes(state, node)
    end
  end
end

require("neo-tree").setup({
  filesystem = {
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["L"] = "toggle_current_node",
        ["H"] = "close_all_nodes",
        ["P"] = "toggle_preview",
        ["r"] = "refresh",
        ["<CR>"] = "open",
        ["<C-v>"] = "open_vsplit",
        ["<C-x>"] = "open_split",
        ["<C-t>"] = "open_tabnew",
        ["q"] = "close_window",
      }
    },
    commands = {
      toggle_current_node = toggle_current_node
    }
  }
})