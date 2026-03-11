#!/bin/bash
# Minify docs/src/ -> docs/ for deployment
# Requires: npm i -g html-minifier-terser csso-cli

DIR="$(cd "$(dirname "$0")" && pwd)"

html-minifier-terser \
  --collapse-whitespace \
  --remove-comments \
  --remove-redundant-attributes \
  --minify-css true \
  --minify-js true \
  "$DIR/src/index.html" -o "$DIR/index.html"

csso "$DIR/src/style.css" -o "$DIR/style-min.css"

echo "Built:"
wc -c "$DIR/src/index.html" "$DIR/src/style.css" | tail -1 | awk '{print "  src: " $1 " bytes"}'
wc -c "$DIR/index.html" "$DIR/style-min.css" | tail -1 | awk '{print "  out: " $1 " bytes"}'
