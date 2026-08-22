
function start_freeze() {
    if [[ $FREEZE -eq 1 ]]; then
        wayfreeze & FREEZE_PID=$!
        sleep .1
    fi
}

function stop_freeze() {
    if [[ $FREEZE -eq 1 ]]; then
        kill "$FREEZE_PID" 2>/dev/null
    fi
}

function select_region() {
    local sel

    start_freeze

    if ! sel=$(slurp 2>/dev/null); then
        stop_freeze
        exit 1
    fi

    stop_freeze

    echo "$sel"
}

function capture() {
    local selection=$1

    if [[ $ANNOTATE -eq 1 ]]; then
        grim -g "$selection" - |
            satty --filename - \
                --early-exit \
                --actions-on-enter save-to-clipboard \
                --copy-command 'wl-copy'
    else
        grim -g "$selection" - | wl-copy
    fi
}

function notify() {
    if [ $SILENT -eq 1 ]; then
        return 0
    fi

    notify-send "Screenshot saved" \
        "Image copied to the clipboard" \
        -t 5000 -a microshot
}

function args() {
    for arg in "$@"; do
        case "$arg" in
            --annotate) ANNOTATE=1 ;;
            --freeze) FREEZE=1 ;;
            --silent) SILENT=1 ;;
            *)
                echo "Unknown argument: $arg" >&2
                exit 1
                ;;
        esac
    done
}

set -euo pipefail

ANNOTATE=0
FREEZE=0
SILENT=0

pkill slurp && exit 0

args "$@"

selection=$(select_region) || exit 0
capture "$selection"
notify
