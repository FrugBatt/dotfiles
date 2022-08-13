#!/bin/bash

# Makes dual borders
# Depends on wmutils/opt
bspwindows() {
  case "${1:-active}" in
  active)
    bspc query -N -n .local.descendant_of.window.leaf.!fullscreen
    ;;
  inactive)
    bspc query -N -n .local.!descendant_of.window.leaf.!fullscreen
    ;;
  esac
}

border_width_current=$(bspc config border_width)

# Half if even, 1px to outer if odd
border_width_in_normal=4
# Border_width_out_normal=$(( border_width_current*5 ))
border_width_out_normal=8
border_width_in_focused=$border_width_in_normal
border_width_out_focused=$border_width_out_normal

background_color=1a1b26
border_color_in_normal=abb2bf
border_color_out_normal=$background_color
border_color_in_focused=abb2bf
border_color_out_focused=$background_color

type theme >/dev/null 2>&1 && eval "$(theme get)"

_chwb2() {
  colorType=$1
  shift
  _getVal() {
    eval echo \$${1}_${colorType}
  }

  [ "$width_normal" = "$width_focused" ] ||
    echo "$@" | sed 's/ /\n/g' | xargs -I{} bspc config -n {} border_width $(_getVal width)

  chwb2 -I $(_getVal border_color_in) -O $(_getVal border_color_out) -i $(_getVal border_width_in) -o $(_getVal border_width_out) $@ 2>/dev/null
}

width_normal=$((border_width_in_normal + border_width_out_normal))
width_focused=$((border_width_in_focused + border_width_out_focused))
bspc config border_width "$width_normal"

_chwb2 focused $(bspwindows)
_chwb2 normal $(bspwindows inactive)

bspc subscribe node_state node_geometry node_focus | while read msg; do
  _chwb2 focused $(bspwindows)
  _chwb2 normal $(bspwindows inactive)
done
