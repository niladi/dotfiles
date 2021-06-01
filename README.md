# Intro

Install script for:
- zsh (automaticly set, default shell)
- oh-my-zsh
- poweline10k (with config, to rerun configuration run `p10k configure`)
- oh-my-zsh plugins: git, zsh-autocomplition, zsh-syntax-highlighting


# Requirements
MesloLGS_NF font

## 1. Download and Install

- [MesloLGS NF Regular.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)
- [MesloLGS NF Bold.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)
- [MesloLGS NF Italic.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)
- [MesloLGS NF Bold Italic.ttf](
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)
    
## 2. Set as font in your terminal

# Execution

## Important
Manually type exit after oh-my-zsh installation, for complete instalation with plugins.

## Installation
### Full
```
curl  https://raw.githubusercontent.com/niladi/zsh-install/master/install-zsh.sh | bash"
```
### With Arguments
```
curl  https://raw.githubusercontent.com/niladi/zsh-install/master/install-zsh.sh | bash -s -- --argument1 --argument2"
```

### Inside Dockerfile for vscode development container
```
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    su vscode -c "curl  https://raw.githubusercontent.com/niladi/zsh-install/master/install-zsh.sh | bash -s -- --vscode" && \
    apt-get purge --autoremove -y curl && \
    rm -rf /var/lib/apt/lists/*
```
