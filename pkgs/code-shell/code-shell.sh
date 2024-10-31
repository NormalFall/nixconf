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
    command -v codium
    command -v code
}

usage () {
    printf "Usage:\n  code-shell [PATH]\n"
}

DIR=$1
CURRENT_DIR=$(pwd)
CODE=$(check_vscode)

#Print usage
if [ "$1" = "-h" ]; then
    usage
    exit
fi

# Check if vscode is installed
if [ -z "$CODE" ]; then
    printf "VsCode not found"
fi

# Find shell type
if [ -z "$DIR" ]; then
    SHELL_TYPE=$(nixshell_exists $CURRENT_DIR)
    SHELL_PATH="$CURRENT_DIR/$SHELL_TYPE"
elif [ -d $DIR ]; then
    SHELL_TYPE=$(nixshell_exists $DIR)
    SHELL_PATH="$DIR/$SHELL_TYPE"
elif [ -f $DIR ]; then
    if [ $DIR=*"/flake.nix" ]; then
        SHELL_TYPE="flake.nix"
    elif [ $DIR=*"/shell.nix" ]; then
        SHELL_TYPE="shell.nix"
    fi
    DIR="$DIR/.."
    SHELL_PATH="$DIR/$SHELL_TYPE"
else
    printf "Invalid path!\n\n"
    usage
    exit 1
fi

# Check if shell type got found
if [ -z "$SHELL_TYPE" ]; then
    printf "Found no valid nix shell\n\n"
    usage
    exit 1
fi

if [ "$SHELL_TYPE" = "flake.nix" ]; then
    nix develop $SHELL_PATH --command zsh -c "SHELL=zsh $CODE ."
elif [ "$SHELL_TYPE" = "shell.nix" ]; then
    nix-shell $SHELL_PATH --command "zsh -c \"SHELL=zsh $CODE .\""
fi
