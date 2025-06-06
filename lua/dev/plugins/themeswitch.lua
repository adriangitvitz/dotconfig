return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
        require("themery").setup({
            themes = {
                "lunaperche",
                "retrobox",
                "sorbet",
                "zenburn",
                "jellybeans-mono",
                "lackluster"
            },                  -- Your list of installed colorschemes.
            livePreview = true, -- Apply theme while picking. Default to true.
        })
    end
}
