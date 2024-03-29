# install Julia
curl -fsSL https://install.julialang.org | sh -s -- --yes 

# Julia startup config file
mkdir -p ~/.julia/config
cp .devcontainer/startup.jl ~/.julia/config/startup.jl

# install Julia packages, registries, ...
/home/vscode/.juliaup/bin/julia .devcontainer/onCreate.jl

# Github CLI autocomplete (https://www.ajfriesen.com/github-cli-auto-completion-with-oh-my-zsh/)
mkdir -p ~/.oh-my-zsh/completions
/usr/bin/gh completion -s zsh > ~/.oh-my-zsh/completions/_gh
echo "autoload -U compinit" >> ~/.zshrc
echo "compinit -i" >> ~/.zshrc

# directory to store Rfam data (set in LocalPreferences.toml)
mkdir -p ~/data/Rfam