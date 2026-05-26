# Emoji Arrow prompt theme for nushell
# Usage: source emoji-arrow.nu
#   or: use emoji-arrow.nu *

export def --env git_prompt_info [] {
    let result = (^git rev-parse --abbrev-ref HEAD | complete)
    let branch = ($result.stdout | str trim)
    if ($branch | is-empty) { return "" }
    $"(ansi blue_bold)git:(ansi red)($branch)(ansi blue)(ansi reset) "
}

export-env {
    $env.PROMPT_COMMAND = {||
        let dir = $"(ansi cyan)($env.PWD | path basename)(ansi reset)"
        let git = (git_prompt_info)
        let arrow = if ($env.LAST_EXIT_CODE == 0) {
            $"(ansi green_bold)🤣👉(ansi reset)"
        } else {
            $"(ansi red_bold)🤣👆(ansi reset)"
        }
        $"($dir) ($git)($arrow) "
    }
}
