FILES=~/.config/environment.d/*
for f in $FILES
do
  while read -r l; do
    eval export "$l"
  done < <(grep . "$f")
done

[ -r "$XDG_CONFIG_HOME/priv/stuff.bash" ] && . "$XDG_CONFIG_HOME/priv/stuff.bash"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_PATH=/usr/local/share/pkgconfig:$PKG_CONFIG_PATH

export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH

if [ -x "$(command -v pyenv)" ]; then
  eval "$(pyenv init --path)"
fi

