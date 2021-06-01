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
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            exit 1
            ;;
    esac
    shift
done

if ! [ $UPDATE ];
then
    sudo apt-get install zsh -y
    chsh -s $(which zsh)

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo apt-get install vim
    
else
    echo "Not installing anything, only updating" 
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

if ! [ $SKIP_RC ];
then 
  curl -fsSL https://raw.githubusercontent.com/niladi/zsh-install/master/.zshrc -o $HOME/.zshrc 
else
  echo "Skipping Copying zshrc"
fi

curl -fsSL https://raw.githubusercontent.com/niladi/zsh-install/master/.p10k.zsh -o $HOME/.p10k.zsh

git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
sh $HOME/.vim_runtime/install_awesome_vimrc.sh
