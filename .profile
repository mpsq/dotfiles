while read -r l; do
   eval export "$l"
done < ~/.config/environment.d/10-all.conf

[ -r "$XDG_CONFIG_HOME/priv/stuff.bash" ] && . "$XDG_CONFIG_HOME/priv/stuff.bash"
