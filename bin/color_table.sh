#!/usr/bin/env bash
printf '==== [ COLOR TABLE ] ====\n'
for i in {0..255} ; do
  printf "\e[38;5;%03dmcolour%-3d  " "${i}" "${i}"
  if [ "$(( i % 8 ))" -eq "7" ];then
    printf "\n"
  fi
done

printf '\n'

# Reset the terminal color to original one.
printf "\e[0m\n"

