"""Checks that no student material links to instructor-only material.

instructor/ and the files in NEVER in tool/release_week.sh exist only in
the instructor's private repository; the script never releases them. A
Markdown link or an HTML href to them would be a broken link in the
public repository, and a sign that student material depends on something
students cannot see. Naming a path in backticks is allowed, and
instructor-only files may link to each other.

Usage: python3 tool/check_private.py   (exit code 1 on any problem)
"""

import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
SUFFIXES = ('.md', '.html', '.yml', '.yaml')
# Instructor-only files, as in NEVER in tool/release_week.sh.
PRIVATE_PREFIXES = ('instructor/', 'CLAUDE.md', 'CHANGELOG.md', 'tool/release_week.sh')
PRIVATE_NAMES = ('EXIT_TASK.md',)
LINK = re.compile(
    r'(\]\(|href=["\'])[^)"\'\s]*'
    r'(\binstructor/|\bCLAUDE\.md|\bCHANGELOG\.md|\brelease_week\.sh|\bEXIT_TASK\.md)'
)


def is_private(name: str) -> bool:
    return name.startswith(PRIVATE_PREFIXES) or name.endswith(PRIVATE_NAMES)


def main() -> int:
    files = subprocess.run(
        ['git', 'ls-files'], cwd=ROOT, check=True, capture_output=True, text=True
    ).stdout.splitlines()
    problems = []
    for name in files:
        if is_private(name) or not name.endswith(SUFFIXES):
            continue
        text = (ROOT / name).read_text(encoding='utf-8', errors='replace')
        for number, line in enumerate(text.splitlines(), start=1):
            if LINK.search(line):
                problems.append(f'{name}:{number}: links to instructor-only material')
    for problem in problems:
        print(problem)
    if problems:
        print('check_private: student material must not link to instructor-only material')
        return 1
    print('check_private: no links to instructor-only material')
    return 0


if __name__ == '__main__':
    sys.exit(main())
