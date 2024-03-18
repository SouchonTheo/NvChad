return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      stages = "fade",
      timeout = 3000,
      background_colour = "#2d2d2d",
      icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
      },
    })
  end,
}
