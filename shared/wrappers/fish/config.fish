set fish_greeting

set fish_transient_prompt 1

# default prompt except with transience added
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status
    set -l normal (set_color --reset)
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'

    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    if contains -- --final-rendering $argv
        echo -n -s $suffix " "
        return
    end

    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end

    set __fish_prompt_status_generation $status_generation

    # sets how many letters of a dir are shown in the prompt pwd
    # increased to 3 here as to avoid ambiguity, e.g. Documents/ and Downloads/
    set -g fish_prompt_pwd_dir_length 3

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end
