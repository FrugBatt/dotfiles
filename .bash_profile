#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	  startx
fi

# opam configuration
test -r /home/archvm/.opam/opam-init/init.sh && . /home/archvm/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
