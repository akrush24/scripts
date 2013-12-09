#!/bin/bash
gconftool-2 --type list --list-type string --set /desktop/gnome/peripherals/keyboard/kbd/layouts '[us,ru]'
