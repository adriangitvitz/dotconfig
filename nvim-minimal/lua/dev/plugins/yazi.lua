return {
    "mikavilpas/yazi.nvim",
    cmd = { "Yazi", "Yazi cwd", "Yazi toggle" },
    opts = {
        open_for_directories = true,
        floating_window_scaling_factor = (is_android and 1.0) or 0.71
    },
}
