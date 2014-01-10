# Load auxiliary configurations
load_files=(~/.bash_private ~/.bash_aliases)

function f () { # Find file in cwd
    find . -name "*$**"
}

function g () { # Grep in cwd
    grep -Ir "$(echo $*)" .
}

function greplace () { # Grep in cwd and replace $1 with $2 in-line
    grep -Irl "$1" . | while read i; do
        echo "Replacing: $i"
        perl -p -i -e "s/$1/$2/g" "$i"
    done
}

function up() { # cd to root of repository
    old_pwd="$PWD";
    while [ 1 ]; do
        cd ..
        if [ "$PWD" == "/" ]; then
            cd "$old_pwd"
            echo "No repository found, returned to $PWD"
            return 1
        fi
        for repo in ".git" ".hg"; do
            if [ -d "$repo" ]; then
                echo "Found $repo at $PWD"
                return 0;
            fi
        done
    done
}
