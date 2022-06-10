function params () {
    echo $1, $2, $3, $4, $5, $6, $7, $8, $9
}

function status () {
    echo $?
}

alias b="vi ~/.bashrc"
alias cb="code ~/.bashrc"

alias sau="sudo apt update"
alias saug="sudo apt upgrade"
alias sai="sudo apt install"
alias saiy="sudo apt install -y"
function s () {
    source ~/.bashrc && 
    source ~/.profile && 
    echo 'sourced:)'

    if [ $? -ne 0 ]; then
        echo "
Error occurred white excuting 's'... :("
    fi
}
alias t="touch"
alias e="exit"
alias md="mkdir"
alias rb="reboot"
function px () {
    pwd | 
    xclip -selection c && 
    echo 'copied current absolute path via pwd!'

    if [ $? -ne 0 ]; then
        echo "
Error occurred white excuting 'px'... :("
    fi
}
alias codo="countdown"
alias ssys="sudo systemctl"
alias ssyss="sudo systemctl status"
alias ssysst="sudo systemctl start"
alias ssysst="sudo systemctl restart"
alias ssyssto="sudo systemctl stop"
function powerup () {
    sudo apt update && 
    sudo apt upgrade -y && 
    sudo apt dist-upgrade -y && 
    sudo apt autoremove -y && 
    sudo apt autoclean -y &&
    echo 'All done. Yay!'

    if [ $? -ne 0 ]; then
        echo "
Error occurred white excuting 'powerup'... :("
    fi
}
function powerupf () {
    sudo apt update 
    sudo apt upgrade -y 
    sudo apt dist-upgrade -y 
    sudo apt autoremove -y 
    sudo apt autoclean -y
    echo 'All done. Yay!'

    if [ $? -ne 0 ]; then
        echo "
Error occurred white excuting 'powerupf'... :("
    fi
}
alias c="curl"

# fzf functions in mac
function fcd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

function fch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf -e --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

function fchb() {
     bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks

     jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r "$jq_script" < "$bookmarks_path" \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf -e --ansi \
        | cut -d$'\t' -f2 \
        | xargs open
}

function fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

function fbrr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

function fns() {
  local script
  script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
}

function fys() {
	local script
	script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && yarn run $(echo "$script")
}
