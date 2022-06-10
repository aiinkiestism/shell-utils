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
