#!/usr/bin/env bash
printf '==== [ COLOR TABLE ] ===='
for i in {0..255} ; do
  printf "\x1b[38;5;%03dmcolour%-3d  " "${i}" "${i}"
  if [ "$(( i % 8 ))" -eq "0" ];then
    printf "\n"
  fi
done

printf '\n'

# Reset the terminal color to original one.
echo -ne "\033[0m"

