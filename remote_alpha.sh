find . -type f -name '*.png' -exec mogrify -alpha off "{}" \;
