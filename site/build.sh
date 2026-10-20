#!/usr/bin/env bash
# Build every weeks/*/slides.md into site/dist/weekNN/index.html (+ slides.pdf)
# and generate site/dist/index.html from site/index.template.html.
# Requires: npx @marp-team/marp-cli (installed by the Pages workflow, or run
# `npm install --no-save @marp-team/marp-cli` locally). PDF export needs
# Chrome/Chromium; it is skipped with a warning if none is found.
set -euo pipefail
cd "$(dirname "$0")/.."

REPO_URL="https://github.com/betsegawlemma/mobile-application-development-course"
FLUTTER_VERSION="$(cat .fvmrc)"
DIST=site/dist
rm -rf "$DIST"; mkdir -p "$DIST"

MARP="npx --no-install @marp-team/marp-cli --no-stdin"
$MARP --version >/dev/null 2>&1 </dev/null || MARP="npx --yes @marp-team/marp-cli --no-stdin"

rows=""
for dir in weeks/week*/; do
  dir="${dir%/}"
  name="$(basename "$dir")"            # week01-intro-dart
  num="${name:4:2}"                    # 01
  # A week appears when its notes or slides are released.
  [[ -f "$dir/README.md" || -f "$dir/slides.md" ]] || continue
  out="$DIST/week$num"

  # Title from the deck's front matter (title:) or README first heading.
  title=""
  if [[ -f "$dir/slides.md" ]]; then
    title="$(grep -m1 '^title:' "$dir/slides.md" | sed 's/^title:[[:space:]]*//; s/^"//; s/"$//' || true)"
  fi
  if [[ -z "$title" && -f "$dir/README.md" ]]; then
    title="$(grep -m1 '^# ' "$dir/README.md" | sed 's/^# //' || true)"
  fi
  [[ -z "$title" ]] && title="$name"

  links=""
  if [[ -f "$dir/slides.md" ]]; then
    mkdir -p "$out"
    $MARP "$dir/slides.md" --theme-set site/theme.css --html -o "$out/index.html"
    links+="<a href=\"week$num/\">Slides</a>"
    if timeout 120 $MARP "$dir/slides.md" --theme-set site/theme.css --html --pdf --allow-local-files -o "$out/slides.pdf" 2>/dev/null; then
      links+="<a href=\"week$num/slides.pdf\">PDF</a>"
    else
      echo "warn: PDF export skipped for $name (no Chrome?)" >&2
    fi
  else
    links+="<span class=\"pill\">slides coming</span>"
  fi
  [[ -f "$dir/README.md" ]]     && links+="<a href=\"$REPO_URL/blob/main/$dir/README.md\">Notes</a>"
  [[ -f "$dir/lab/README.md" ]] && links+="<a href=\"$REPO_URL/blob/main/$dir/lab/README.md\">Lab</a>"
  [[ -f "$dir/quiz.md" ]]       && links+="<a href=\"$REPO_URL/blob/main/$dir/quiz.md\">Quiz</a>"

  rows+="      <tr><td>${num#0}</td><td>${title}</td><td class=\"links\">${links}</td></tr>"$'\n'
done

python3 - "$DIST/index.html" "$REPO_URL" "$FLUTTER_VERSION" "$rows" <<'PY'
import sys, datetime
out, repo, ver, rows = sys.argv[1:5]
tpl = open('site/index.template.html').read()
html = (tpl.replace('__REPO_URL__', repo).replace('__FLUTTER_VERSION__', ver)
           .replace('__ROWS__', rows.rstrip('\n'))
           .replace('__BUILD_DATE__', datetime.date.today().isoformat()))
open(out, 'w').write(html)
PY
touch "$DIST/.nojekyll"
echo "Built $(ls $DIST/week*/index.html 2>/dev/null | wc -l) deck(s) into $DIST"
