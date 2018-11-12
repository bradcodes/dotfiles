#!/bin/bash
 
# or use wm array -- add any that need to be recognized
wms=( 2bwm 2wm 9wm aewm afterstep ahwm alopex amiwm antiwm awesome blackbox bspwm catwm clfswm ctwm cwm dminiwm dragonflywm dwm echinus \
  euclid-wm evilpoison evilwm fluxbox flwm fvwm-crystal goomwwm hcwm herbstluftwm i3 icewm jwm karmen larswm lwm matwm2 mcwm monsterwm \
  musca notion nwm olwm openbox oroborus pekwm ratpoison sapphire sawfish sscrotwm sithwm smallwm snapwm spectrwm stumpwm subtle tfwm tinywm tritium twm \
  uwm vtwm w9wm weewm wind windowlab wm2 wmaker wmfs wmii wmx xfwm4 xmonad xoat yeahwm )
 
# define colors for color-echo
red="\e[31m"
grn="\e[32;1m"
ylw="\e[33m"
cyn="\e[36m"
blu="\e[34m"
prp="\e[35m"
bprp="\e[35;1m"
rst="\e[0m"
 
color-echo()
{  # print with colors
  echo -e " $grn$1\t: $rst$2"
}
green-echo()
{ # for the main logo
  echo -en " $grn$1"
}
 
print-kernel()
{
  #color-echo 'KERN\t' "$(cat /sys/devices/virtual/dmi/id/product_name)"
  color-echo 'KERN' "$(uname -rs)"
}
 
print-uptime()
{
  up=$(</proc/uptime)
  up=${up//.*}                # string before first . is seconds
  days=$((${up}/86400))       # seconds divided by 86400 is days
  hours=$((${up}/3600%24))    # seconds divided by 3600 mod 24 is hours
  mins=$((${up}/60%60))       # seconds divided by 60 mod 60 is mins
  color-echo "UP" $days'd '$hours'h '$mins'm'
}
print-user () {
  # echo user @ host"
  color-echo 'HOST' "$(hostname)" 
}
 
print-shell() {
  color-echo 'SHELL' "$(echo $SHELL)"
}
 
print-cpu()
{
  arm=$(grep ARM /proc/cpuinfo)    # ARM procinfo uses different format
  if [[ "$arm" != "" ]]; then
    cpu=$(grep -m1 -i 'Processor' /proc/cpuinfo)
  else
    cpu=$(grep -m1 -i 'model name' /proc/cpuinfo)
  fi
  color-echo 'CPU' "${cpu#*: }" # everything after colon is processor name
}
 
print-gpu()
{
  gpu=$(lspci | grep VGA | awk -F ': ' '{print $2}' | sed 's/(rev ..)//g')
  color-echo 'GPU\t' "$gpu"
}
 
print-packages()
{
  packages=$(pacman -Q|wc -l)
  color-echo 'PKG' "$packages"
}
 
print-wm()
{
  for wm in ${wms[@]}; do          # pgrep through wmname array
    pid=$(pgrep -x -u $USER $wm) # if found, this wmname has running process
    if [[ "$pid" ]]; then
      color-echo 'WM' $wm
      break
    fi
  done
}
 
print-distro()
{
  [[ -e /etc/os-release ]] && source /etc/os-release
  if [[ -n "$PRETTY_NAME" ]]; then
    color-echo 'OS' "$PRETTY_NAME"
  else
    color-echo 'OS' "not found"
  fi
}
 
#echo
#green-echo "  █▀▀▀▀▀▀▀▀█  " && print-distro
#green-echo "  █        █  " && print-kernel
#green-echo "  █  x  x  █  " && print-packages
#green-echo "  █        █  " && print-shell
#green-echo "  ▀█▄▄▄▄▄▄█▀  " && print-uptime
#echo

echo
green-echo " ███████ ███   " && print-user
green-echo " ███████ ███   " && print-distro
green-echo " ███     ███   " && print-kernel
green-echo " ███ ███ ███   " && print-packages
green-echo " ███ ███ ███   " && print-shell
green-echo " ███ ███ ███   " && print-uptime
echo
 
#print-colors
