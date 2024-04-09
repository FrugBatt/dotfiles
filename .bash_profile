#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  startx
fi

# opam configuration
# test -r /home/hugo/.opam/opam-init/init.sh && . /home/hugo/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# >>> coursier install directory >>>
export PATH="$PATH:/home/hugo/.local/share/coursier/bin"
# <<< coursier install directory <<<
. "$HOME/.cargo/env"
