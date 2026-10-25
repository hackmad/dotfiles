# Paths
export PATH="$HOME/.local/bin:$PATH"

# RubyGems
if [[ "$(uname -s)" == "Darwin" ]]; then
    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
else
    export GEM_HOME="$(gem env user_gemhome)"
fi
export PATH="$PATH:$GEM_HOME/bin"

export PATH="$PATH:$HOME/Software/Zig:$HOME/Software/ZLS"
