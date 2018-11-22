function fish_prompt
    if not set -q $__fish_prompt_hostname
      set -g __fish_prompt_hostname (hostname)
    end
 
    set_color $fish_color_cwd
    echo -n "$__fish_prompt_hostname"
    echo -n (hostname)
    set_color normal
    echo -n ' # '
end
