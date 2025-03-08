RED='\033[31m'
YELLOW='\033[33m'
BLUE='\033[34m'
NC='\033[0m' # No Color

nixshell_exists () {
    if [ -f $1/flake.nix ]; then
        printf "flake.nix"
    elif [ -f $1/shell.nix ]; then
        printf "shell.nix"
    else
        printf ""
    fi
}

check_vscode () {
    command -v codium || command -v code
}

open_dir () {
    printf "SHELL="$SHELL" $CODE -n \"$DIR\""
}

usage () {
    printf "Usage:\n  code-shell [PATH]\n"
}

DIR="$1"
CURRENT_DIR="$(pwd)"
CODE="$(check_vscode)"

#Print usage
if [ "$1" = "-h" ]; then
    usage
    exit
fi

# Check if vscode is installed
if [ -z "$CODE" ]; then
    printf "${RED}Error${NC}: No vscode installation found!\n\n"
fi

# Find shell type
if [ -z "$DIR" ]; then # If no args are given look in current dir.
    SHELL_TYPE="$(nixshell_exists "$CURRENT_DIR")"
    SHELL_PATH="$CURRENT_DIR"
    DIR="$CURRENT_DIR"
elif [ -d "$DIR" ]; then
    SHELL_TYPE="$(nixshell_exists "$DIR")"
    SHELL_PATH="$DIR"

elif [ -f "$DIR" ]; then
    if [[ "$DIR" = */flake.nix ]]; then
        SHELL_TYPE="flake.nix"
    elif [[ "$DIR" = */shell.nix ]]; then
        SHELL_TYPE="shell.nix"
    elif [[ "$DIR" = *.nix ]]; then # It's possible to have shell files named other than shell.nix
        SHELL_TYPE="shell.nix"
    fi

    if [ "$SHELL_TYPE" = "shell.nix" ]; then
        SHELL_PATH="$DIR"
        DIR="$DIR/.."
    else
        DIR="$DIR/.."
        SHELL_PATH="$DIR"
    fi
else
    printf "${RED}Error${NC}: Invalid path!\n\n"
    usage
    exit 1
fi

# Check if shell type got found
if [ -z "$SHELL_TYPE" ]; then
    printf "${YELLOW}Warning${NC}: Found no valid nix shell. Opening VSCode anyway\n\n"
    eval "$(open_dir)"
    exit 0
fi

printf "Shell type is: ${BLUE}${SHELL_TYPE}${NC}\n\n"

if [ "$SHELL_TYPE" = "flake.nix" ]; then
    nix develop "$SHELL_PATH" --command zsh -c "$(open_dir)"

    # Run shell anyway if flake has no shell
    if [ $? -ne 0 ]; then
        printf "${YELLOW}Warning${NC}: Flake failed to get nix shell. Opening VSCode anyway\n\n"
        eval "$(open_dir)"
    fi
elif [ "$SHELL_TYPE" = "shell.nix" ]; then
    nix-shell "$SHELL_PATH" --command "$(open_dir)"
fi
