if [[ ! -o interactive ]]; then
    return
fi

compctl -K _bad bad

_bad() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(bad commands)"
  else
    completions="$(bad completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
