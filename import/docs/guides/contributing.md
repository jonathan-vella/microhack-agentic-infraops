# Contributing Guide

> [Current Version](../../VERSION.md) | Branch, commit, PR conventions, and automated versioning

All changes go through pull requests on a protected `main` branch with automated quality checks.

---

## Git Workflow

### 1. Create a Feature Branch

```bash
git checkout main && git pull origin main
git checkout -b feat/add-challenge-7
```

**Branch naming:**

| Prefix      | Use for               |
| ----------- | --------------------- |
| `feat/`     | New features          |
| `fix/`      | Bug fixes             |
| `docs/`     | Documentation changes |
| `refactor/` | Code restructuring    |
| `chore/`    | Maintenance tasks     |

### 2. Commit with Conventional Commits

```bash
git add .
git commit -m "feat(microhack): add challenge 7 with advanced scenarios"
```

Pre-commit hooks run automatically via **lefthook**:

| Hook         | When              | Runs                         |
| ------------ | ----------------- | ---------------------------- |
| `pre-commit` | Before commit     | Markdown lint, link check    |
| `commit-msg` | After commit text | Commitlint format validation |

### 3. Push and Create PR

```bash
git push -u origin feat/add-challenge-7
gh pr create --fill
```

### 4. Merge

Use **Squash and Merge** only — this keeps a clean linear history and preserves all PR
context in the commit body.

```bash
gh pr merge --squash --delete-branch
```

---

## Repository Rulesets

The `main` branch is protected via [GitHub rulesets][rulesets]:

| Rule                        | Description                  | Bypass     |
| --------------------------- | ---------------------------- | ---------- |
| **Require PR**              | Direct pushes blocked        | Admin only |
| **Require approval**        | 1 approval needed            | Admin only |
| **Status checks**           | `markdown-lint` must pass    | None       |
| **Up-to-date branch**       | Must be current with main    | None       |
| **Conversation resolution** | All threads must be resolved | None       |
| **Linear history**          | Squash merge only            | None       |
| **No force push**           | History cannot be rewritten  | None       |
| **No deletion**             | Branch cannot be deleted     | None       |

---

## Automated Checks

### Markdown Linting

Every PR triggers markdownlint. Fix issues locally:

```bash
npm run lint:md          # Check
npm run lint:md:fix      # Auto-fix
```

Rules enforced: line length ≤ 120 chars, heading hierarchy, no trailing whitespace, and 40+
more. Config: `.markdownlint-cli2.jsonc`.

### Link Validation

```bash
npm run lint:links       # Check all links
npm run lint:links:docs  # Docs folder only
```

Add persistent false positives to `.markdown-link-check.json` ignore patterns.

### Commit Message Validation

Uses `commitlint` (via lefthook). Valid types: `feat`, `fix`, `docs`, `chore`, `style`,
`refactor`, `perf`, `test`, `build`, `ci`, `revert`.

If validation fails, amend:

```bash
git commit --amend -m "feat: correct message format"
```

---

## Conventional Commits and Versioning

The `.github/workflows/auto-version.yml` workflow automatically bumps the version on every
`feat:` or `fix:` merge to `main`.

### Version Bump Rules

| Commit Type                                       | Bump              | Example                               |
| ------------------------------------------------- | ----------------- | ------------------------------------- |
| `feat:`                                           | **Minor** (1.X.0) | `feat: add challenge 7`               |
| `fix:`                                            | **Patch** (1.0.X) | `fix: correct timing in agenda`       |
| `feat!:` or `BREAKING CHANGE:`                    | **Major** (X.0.0) | `feat!: redesign microhack structure` |
| `docs:`, `chore:`, `style:`, `refactor:`, `test:` | **No bump**       | `docs: update README`                 |

### Scopes (Optional)

| Scope         | Example                                          |
| ------------- | ------------------------------------------------ |
| `microhack`   | `fix(microhack): correct curveball timing`       |
| `facilitator` | `feat(facilitator): add troubleshooting section` |
| `agent`       | `feat(agent): add validation agent`              |
| `workflow`    | `fix(workflow): update auto-version trigger`     |

### After a `feat:` or `fix:` Merge

1. Workflow creates a release PR (`release/vX.Y.Z`) updating `VERSION.md` and `CHANGELOG.md`
2. Review and merge the release PR (squash)
3. Manually create the GitHub Release:

```bash
gh release create v1.2.0 --generate-notes
```

### Manual Version Override

```bash
git commit -m "chore(release): bump version to 2.0.0 [skip ci]"
git tag -a v2.0.0 -m "Release v2.0.0"
git push origin main --tags
```

---

## Common Workflows

### Documentation Fix

```bash
git checkout main && git pull
git checkout -b docs/fix-typo
# Edit files...
git add . && git commit -m "docs: fix typo in quickstart"
git push -u origin docs/fix-typo
gh pr create --fill && gh pr merge --squash --delete-branch
```

### Fix PR Check Failures

```bash
npm run lint:md:fix
git add . && git commit -m "fix: correct markdown formatting"
git push
```

### Review a Version Bump PR

```bash
git fetch origin && git checkout release/v1.2.0
cat VERSION.md && cat CHANGELOG.md | head -50
gh pr review --approve
gh pr merge --squash --delete-branch
git checkout main && git pull
gh release create v1.2.0 --generate-notes
```

---

## Troubleshooting

| Problem                              | Solution                                                 |
| ------------------------------------ | -------------------------------------------------------- |
| Protected branch push rejected       | Create a branch and PR — never push directly to `main`   |
| `MD013/line-length` lint error       | `npm run lint:md:fix` then fix any remaining manually    |
| Commitlint subject format error      | `git commit --amend -m "feat: sentence case subject"`    |
| Merge conflict in `VERSION.md`       | Rebase on latest main, resolve, commit with `[skip ci]`  |
| Workflow didn't trigger auto-version | Ensure commit type is `feat:` or `fix:` and is on `main` |

---

## Best Practices

**Do:**

- Pull before branching — always start from latest `main`
- Write small, focused, reviewable PRs
- Run lint locally before pushing
- Delete branches after merge

**Don't:**

- Push directly to `main`
- Bypass pre-commit hooks (`--no-verify`)
- Mix unrelated changes in one PR
- Force push — it rewrites history

---

## References

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)
- [Contributing Guidelines](../../CONTRIBUTING.md)

[rulesets]: https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets
