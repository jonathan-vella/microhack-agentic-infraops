#!/usr/bin/env python3
"""Convert Jekyll callouts and <details> blocks to MkDocs Material admonitions.

Usage:
    python scripts/convert-callouts.py docs/

Processes all .md files under the given directory (recursively).

Two transformations:
  1. IAL callouts:  blockquote lines followed by {: .type } → !!! type
  2. <details> blocks → ??? note "title"

IAL callouts are processed first (line-level), then <details> (multi-line).
"""

import re
import sys
from pathlib import Path

# Mapping from Jekyll IAL class to MkDocs admonition type
CALLOUT_MAP = {
    "note": "note",
    "tip": "tip",
    "warning": "warning",
    "important": "important",
    "time": 'warning "Time"',
}

IAL_PATTERN = re.compile(r"^\{:\s*\.(\w+)\s*\}\s*$")


def convert_ial_callouts(lines: list[str]) -> list[str]:
    """Convert IAL-syntax callouts to admonition blocks."""
    result = []
    i = 0
    while i < len(lines):
        line = lines[i]
        match = IAL_PATTERN.match(line.strip())
        if match:
            callout_type = match.group(1)
            admonition = CALLOUT_MAP.get(callout_type)
            if admonition and result:
                # Walk back to collect the blockquote lines
                bq_lines = []
                while result and result[-1].startswith(">"):
                    bq_lines.insert(0, result.pop())
                # Remove the leading "> " from each line
                body_lines = []
                for bq in bq_lines:
                    stripped = re.sub(r"^>\s?", "", bq).rstrip()
                    body_lines.append(stripped)
                # Strip leading/trailing blank body lines
                while body_lines and not body_lines[0].strip():
                    body_lines.pop(0)
                while body_lines and not body_lines[-1].strip():
                    body_lines.pop()
                # Build admonition
                result.append(f"!!! {admonition}\n")
                result.append("\n")
                for bl in body_lines:
                    result.append(f"    {bl}\n" if bl.strip() else "\n")
                result.append("\n")
                i += 1
                continue
        result.append(line)
        i += 1
    return result


DETAILS_OPEN = re.compile(
    r'<details\s[^>]*markdown\s*=\s*"1"[^>]*>', re.IGNORECASE)
SUMMARY_RE = re.compile(
    r"<summary>\s*(?:<strong>)?\s*(.*?)\s*(?:</strong>)?\s*</summary>", re.IGNORECASE
)
DETAILS_CLOSE = re.compile(r"</details>", re.IGNORECASE)


def convert_details_blocks(lines: list[str]) -> list[str]:
    """Convert <details markdown='1'> blocks to collapsible admonitions."""
    result = []
    i = 0
    while i < len(lines):
        line = lines[i]
        if DETAILS_OPEN.search(line):
            # Look for <summary> on next lines
            title = "Details"
            j = i + 1
            while j < len(lines):
                summary_match = SUMMARY_RE.search(lines[j])
                if summary_match:
                    title = summary_match.group(1).strip()
                    # Clean any remaining HTML tags
                    title = re.sub(r"<[^>]+>", "", title).strip()
                    j += 1
                    break
                elif lines[j].strip():
                    # Non-empty, non-summary line — no summary found
                    break
                j += 1

            # Collect body until </details>
            body_lines = []
            while j < len(lines):
                if DETAILS_CLOSE.search(lines[j]):
                    j += 1
                    break
                body_lines.append(lines[j])
                j += 1

            # Strip leading/trailing blank lines from body
            while body_lines and not body_lines[0].strip():
                body_lines.pop(0)
            while body_lines and not body_lines[-1].strip():
                body_lines.pop()

            # Write collapsible admonition
            result.append(f'??? note "{title}"\n')
            result.append("\n")
            for bl in body_lines:
                stripped = bl.rstrip()
                if stripped:
                    result.append(f"    {stripped}\n")
                else:
                    result.append("\n")
            result.append("\n")

            i = j
            continue

        result.append(line)
        i += 1
    return result


def strip_jekyll_frontmatter(lines: list[str]) -> list[str]:
    """Remove Jekyll-specific frontmatter keys, keep title and description."""
    if not lines or lines[0].strip() != "---":
        return lines

    # Find closing ---
    end = None
    for idx in range(1, len(lines)):
        if lines[idx].strip() == "---":
            end = idx
            break
    if end is None:
        return lines

    # Filter frontmatter keys
    jekyll_keys = {
        "layout",
        "parent",
        "nav_order",
        "has_children",
        "has_toc",
        "permalink",
    }
    new_fm = ["---\n"]
    for line in lines[1:end]:
        key = line.split(":")[0].strip() if ":" in line else ""
        if key not in jekyll_keys:
            new_fm.append(line)
    new_fm.append("---\n")

    # If only --- / --- remain (no kept keys), drop frontmatter entirely
    kept = [l for l in new_fm[1:-1] if l.strip()]
    if not kept:
        return lines[end + 1:]

    return new_fm + lines[end + 1:]


def process_file(path: Path) -> bool:
    """Process a single markdown file. Returns True if modified."""
    original = path.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)

    lines = strip_jekyll_frontmatter(lines)
    lines = convert_ial_callouts(lines)
    lines = convert_details_blocks(lines)

    result = "".join(lines)
    if result != original:
        path.write_text(result, encoding="utf-8")
        return True
    return False


def main():
    if len(sys.argv) < 2:
        print("Usage: python convert-callouts.py <docs-directory>")
        sys.exit(1)

    docs_dir = Path(sys.argv[1])
    if not docs_dir.is_dir():
        print(f"Error: {docs_dir} is not a directory")
        sys.exit(1)

    modified = 0
    for md_file in sorted(docs_dir.rglob("*.md")):
        if process_file(md_file):
            print(f"  converted: {md_file}")
            modified += 1

    print(f"\nDone. {modified} file(s) modified.")


if __name__ == "__main__":
    main()
