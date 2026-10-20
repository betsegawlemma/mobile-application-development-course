"""Checks that every lab starter still leaves the lab's work to the student.

For each weeks/*/lab/{starter,solution} pair it reports:

1. a starter file with a TODO(lab) marker that is identical to the
   solution file (the task is already done, or the solution still has
   the marker);
2. a file named in a core lab task (### Task N, not an extra task) that
   differs between starter and solution but has no TODO(lab) marker in
   the starter (the student is not told where to work);
3. a file named in a core lab task that is identical in starter and
   solution and has no TODO(lab) marker (the task has nothing to do),
   unless the file is listed in tool/check_starters.allow because the
   task only reads it.

Generated files and test files are skipped: tests are given and are the
same in both folders on purpose.

Usage: python3 tool/check_starters.py   (exit code 1 on any problem)
"""

import filecmp
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
SKIP_SUFFIXES = ('.g.dart', '.freezed.dart')
SKIP_PARTS = {'build', '.dart_tool', 'node_modules', 'test', 'integration_test'}
MARKER = 'TODO(lab)'
PATH_RE = re.compile(r'`([\w./-]+\.(?:dart|rules|json|yaml|arb))`')


def load_allow():
    allow = set()
    f = ROOT / 'tool' / 'check_starters.allow'
    if f.exists():
        for line in f.read_text().splitlines():
            line = line.split('#', 1)[0].strip()
            if line:
                allow.add(line)
    return allow


def skipped(rel):
    return rel.name.endswith(SKIP_SUFFIXES) or SKIP_PARTS & set(rel.parts)


def files(base):
    for p in base.rglob('*'):
        rel = p.relative_to(base)
        if p.is_file() and not skipped(rel) and p.suffix in (
                '.dart', '.rules', '.json', '.yaml', '.arb', '.md'):
            yield rel


def has_marker(p):
    try:
        return MARKER in p.read_text(encoding='utf-8')
    except (UnicodeDecodeError, FileNotFoundError):
        return False


def core_task_paths(readme):
    """Yield (task heading, path text) for every path in a core task."""
    if not readme.exists():
        return
    heading = None
    for line in readme.read_text(encoding='utf-8').splitlines():
        if line.startswith('#'):
            heading = None
            if line.startswith('### Task') and 'extra task' not in line.lower():
                heading = line.lstrip('# ').strip()
            continue
        if heading:
            for m in PATH_RE.finditer(line):
                yield heading, m.group(1)


def resolve(starter, text, starter_files):
    """Find the starter file a README path refers to."""
    text = text.lstrip('./')
    for prefix in ('', 'lab/starter/'):
        if text.startswith(prefix) and (starter / text[len(prefix):]).is_file():
            return pathlib.Path(text[len(prefix):])
    matches = [f for f in starter_files
               if str(f) == text or str(f).endswith('/' + text)]
    return matches[0] if len(matches) == 1 else None


def main():
    allow = load_allow()
    problems = []
    for lab in sorted(ROOT.glob('weeks/*/lab')):
        starter, solution = lab / 'starter', lab / 'solution'
        if not (starter.is_dir() and solution.is_dir()):
            continue
        week = lab.parent.name
        starter_files = list(files(starter))

        for rel in starter_files:
            other = solution / rel
            if has_marker(starter / rel) and other.is_file() and \
                    filecmp.cmp(starter / rel, other, shallow=False):
                problems.append(f'{week}: {rel} has a {MARKER} marker but '
                                'is identical to the solution')

        seen = set()
        for heading, text in core_task_paths(lab / 'README.md'):
            rel = resolve(starter, text, starter_files)
            if rel is None or skipped(rel) or (heading, rel) in seen:
                continue
            seen.add((heading, rel))
            other = solution / rel
            if not other.is_file():
                continue
            same = filecmp.cmp(starter / rel, other, shallow=False)
            marked = has_marker(starter / rel)
            if f'{week} {rel}' in allow or marked:
                continue
            if same:
                problems.append(f'{week}: "{heading}" names {rel}, which is '
                                'identical in starter and solution and has no '
                                f'{MARKER} marker')
            else:
                problems.append(f'{week}: "{heading}" names {rel}, which the '
                                f'student must change, but it has no {MARKER} '
                                'marker in the starter')

    for p in problems:
        print('error:', p)
    if problems:
        print(f'\nIf a task only reads a file, add "<week> <path>" to '
              'tool/check_starters.allow.')
        return 1
    print('check_starters: every starter leaves its lab tasks to the student')
    return 0


if __name__ == '__main__':
    sys.exit(main())
