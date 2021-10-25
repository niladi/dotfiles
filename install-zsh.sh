#!/bin/sh



while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            exit
            ;;
        --skip-rc)
            SKIP_RC=true
            ;;
        --update)
            UPDATE=true
            ;;
        --vscode)
            VSCODE=true
            ;;
        --skip-vim)
            SKIP_VIM=true
            ;;
        --default)
            DEFAULT=true
            ;;
        --user)
            USER=true
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            exit 1
            ;;
    esac
    shift
done

cat << EOF
 ______    _     _____           _        _ _ 
|___  /   | |   |_   _|         | |      | | |
   / / ___| |__   | |  _ __  ___| |_ __ _| | |
  / / / __| '_ \  | | | '_ \/ __| __/ _` | | |
 / /__\__ \ | | |_| |_| | | \__ \ || (_| | | |
/_____|___/_| |_|_____|_| |_|___/\__\__,_|_|_|

Running with the following config:
skip coping zshrc: $SKIP_RC
update: $UPDATE
vscode: $VSODE
as non root: $USER
set zsh as default: $DEFAULT
skip vim: $SKIP_VIM
EOF

if [ $UPDATE ];
then
    echo "Not installing anything, only updating" 
else
    if [ $USER ];
    then
        echo "installing without root privileges"
        curl  https://raw.githubusercontent.com/niladi/zsh-install/master/user-install-zsh-tmux.sh | bash
    else
        if  [ $VSCODE ];
        then
            echo "skipping install"
        else 
            sudo apt-get install zsh tmux -y
            if [ $DEFAULT ];
            then
                chsh -s $(which zsh)
            fi

            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        fi

        if [ $SKIP_VIM ];
        then
            echo "not installing vim"
        else
            sudo apt-get install vim -y
        fi
    fi
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

if [ $SKIP_RC ];
then 
    echo "Skipping Copying zshrc"
else
     curl -fsSL https://raw.githubusercontent.com/niladi/zsh-install/master/.zshrc -o $HOME/.zshrc 
fi

curl -fsSL https://raw.githubusercontent.com/niladi/zsh-install/master/.p10k.zsh -o $HOME/.p10k.zsh
curl -fsSL https://raw.githubusercontent.com/niladi/zsh-install/master/.tmux.conf -o $HOME/.tmux.conf 

if [ $SKIP_VIM ];
then
    echo "not installing awsome vim"
else
    git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
    sh $HOME/.vim_runtime/install_awesome_vimrc.sh
fi
