return {
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onenord").setup({
        borders = true,
        fade_nc = false,
        styles = {
          comments = "italic",
          keywords = "bold",
        },
        disable = {
          background = true,
          cursorline = false,
          eob_lines = true,
        },
      })
    end,
  },
}

