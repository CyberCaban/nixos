return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http" },
  opts = {
    -- your configuration comes here
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
    contenttypes = {
      ["application/json"] = {
        formatter = vim.fn.executable("jaq") == 1 and { "jq", "." },
        pathresolver = function(...)
          return require("kulala.parser.jsonpath").parse(...)
        end,
      },
    },
  },
}
