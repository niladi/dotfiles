#!/usr/bin/env bash

# Connect to the server.. 
# ssh username@server_ip
mkdir ~/.local;

# Download source and build libevent
cd /tmp;
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz;
tar xvfz libevent-2.1.8-stable.tar.gz;
cd libevent-2.1.8-stable;
./configure --prefix=$HOME/.local;
make;
make install;

# Download source and build ncurses
cd /tmp;
wget http://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz;
tar xvfz ncurses-6.0.tar.gz;
cd ncurses-6.0;
./configure --prefix=$HOME/.local;
make;
make install;

# Download source and build zsh
cd /tmp;
wget -O zsh.tar.gz https://sourceforge.net/projects/zsh/files/latest/download;
mkdir zsh && tar -xvzf zsh.tar.gz -C zsh --strip-components 1;
cd zsh;
./configure --prefix=$HOME/.local;
make;
make install;

# Download the source and build tmux
cd /tmp;
wget https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz;
tar xvfz tmux-2.3.tar.gz;
cd tmux-2.3;
./configure CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" \
            LDFLAGS="-static -L$HOME/.local/include \
                     -L$HOME/.local/include/ncurses -L$HOME/.local/lib";
make;

# `make install` DOESN'T WORK, SO DON'T EVEN TRY,
# also -static makes it so we don't need to dynamically link shared files in $HOME/.local/lib meaning
# exporting a LD shell variable. We can just copy it and run it.

cp tmux ~/.local/bin;
export PATH=$HOME/.local/bin:$PATH;

echo "At this point, you should be able to just type tmux on the command line and have it work."
echo "Otherwise, the binary was installed to $HOME/local/bin, and you can run it by calling it directly from that directory"
