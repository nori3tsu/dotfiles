source ~/.bash_profile

PS1="[${USER}%F{blue}@%f${HOST%%.*} %1~]%(?,%F{green},%F{red})%(!.#.$)%f "
