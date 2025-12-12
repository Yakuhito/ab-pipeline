watch -n 1 'for dir in output_*; do [ -d "$dir" ] && num=$(ls -1 "$dir" | wc -l) && perc=$(echo "scale=2; $num * 100 / 913" | bc) && echo "$dir: $num/913 ($perc%)"; done'
