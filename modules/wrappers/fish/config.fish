set fish_greeting

set fish_transient_prompt 1

# stripped default function with modified prompt
function prompt_login --description "display user name for the prompt"
    # If we're running via SSH, change the host color.
    set -l color_host $fish_color_host
    if set -q SSH_TTY; and set -q fish_color_host_remote
        set color_host $fish_color_host_remote
    end

	set -l normal (set_color --reset)
    set -l purple (set_color --bold cdb4db)

    echo -n -s $purple '[' $normal "$USER" $purple ']' $normal @ $purple '[' $normal (prompt_hostname) $purple ']' $normal
end

# default prompt except with transience added
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status
    set -l normal (set_color --reset)
    set -l color_cwd ffc8dd
    set -l suffix '>'

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
