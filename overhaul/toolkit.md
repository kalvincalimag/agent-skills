# Overhaul toolkit

Analyzers and refactoring levers by ecosystem, compiled in November 2026. Prefer tools the project already runs. Confirm current names and flags in each tool's docs before relying on them.

## JavaScript and TypeScript

- **Dead code.** knip finds unused files, exports, types, and dependencies, and `knip --fix` removes some of them. Its config and CLI flags can narrow it to fewer checks, so read both. fallow bundles dead code, duplication, complexity, cycles, and boundary presets in one Rust binary, and `fallow audit` fails only on findings a change introduces.
- **Duplication.** jscpd, with `--threshold` for a duplicated-percentage limit.
- **Size and complexity.** ESLint core rules `complexity`, `max-lines`, `max-lines-per-function`, and `max-depth`. eslint-plugin-sonarjs adds cognitive complexity.
- **Boundaries.** dependency-cruiser checks dependency rules and can record existing violations as known, so only new ones fail. eslint-plugin-boundaries enforces element types in lint. madge finds cycles.
- **Type escapes.** typescript-eslint rules `no-explicit-any`, the `no-unsafe-*` family, `consistent-type-assertions`, and `ban-ts-comment`.
- **Levers.** ts-morph, jscodeshift, ast-grep, and the TypeScript language server's rename and move-to-file refactors.

## Python

- **Dead code.** vulture.
- **Duplication.** pylint `duplicate-code`, or jscpd.
- **Complexity.** ruff `C901` and the pylint-derived `PLR09` limits, or lizard. radon still works but has had no release since 2023.
- **Boundaries.** import-linter contracts for layers, independence, and forbidden imports.
- **Type escapes.** mypy or pyright in strict mode, and ruff `ANN401` for `Any`.
- **Levers.** LibCST codemods and Rope.

## Go

- **Dead code.** `golang.org/x/tools/cmd/deadcode`, and the `unused` linter.
- **Everything else.** golangci-lint with `dupl`, `gocyclo`, `gocognit`, and `depguard`. Its `--new-from-rev` flag reports only issues added since a revision.
- **Levers.** gopls rename, `gofmt -r`, and ast-grep.

## JVM

- **Duplication.** PMD CPD.
- **Boundaries.** ArchUnit expresses architecture rules as unit tests.
- **Kotlin.** Detekt for complexity and size.
- **Levers.** OpenRewrite recipes and the IDE refactoring engine.

## Any language

- **lizard.** Complexity and function length for many languages.
- **jscpd.** Duplication across most text formats.
- **Semgrep and ast-grep.** Custom pattern rules, and rewrites for ast-grep.
- **SonarQube Community and qlty.** Multi-language dashboards with gates on new code.
- **CodeQL.** Security weaknesses.

## Dead surface beyond imports

- **Database.** Search the repository, raw SQL, views, and other services for each table and column name. In PostgreSQL, `pg_stat_user_tables` counts scans and writes per table and `pg_stat_user_indexes` shows indexes with `idx_scan = 0`. Both count only since the last statistics reset, so check `stats_reset` in `pg_stat_database` first. PostgreSQL keeps no per-column read statistics, so a column's proof is the code search plus a count of non-null values.
- **API endpoints.** List the routes the code serves, the operations the API contract documents, and the routes with requests in the access logs or APM over the window. A route in the first list but not the third is a candidate. A route in the contract but not the code is a stale contract entry.
- **Pages.** Frameworks with file-based routing treat every page as an entry point, so dead-code analyzers never flag a page. knip's framework plugins do the same. Use analytics or access logs.
- **CSS, translations, and assets.** fallow reports CSS drift. Translation-key checkers for the project's i18n library find unused keys. Search for asset file names before deleting the files.
- **Redundant indexes.** In PostgreSQL, compare the column lists in `pg_index` for each table. An index whose columns equal another's, or form a leading prefix of another's, is a candidate. Check `indisunique` and `indisprimary` before dropping it.
- **Redundant columns and endpoints.** No tool finds these reliably. List columns with similar names or identical values across tables, and contract operations that touch the same resource with the same method, then confirm each pair by reading the code.
- **Flags.** Most flag services report stale flags that have served one value for a long time. Remove the flag in code first, then in the service.

## Churn hotspots

Count commits per file over the last year:

```bash
git log --since="12 months ago" --format= --name-only | sort | uniq -c | sort -rn | head -50
```

Join the counts with complexity per file and sort by the product. code-maat adds change coupling and ownership analysis from the same log.

## AI-slop scorers

None of these has an independent accuracy evaluation, and their scores are not comparable. Each scores a repository on its own scale and is not a probability that an AI wrote the code.

- **aislop.** 50+ rules across 11 languages, a 0 to 100 score, no model calls.
- **slop-scan.** JavaScript and TypeScript, with a score normalized against open-source repositories from before AI coding tools were common.
- **desloppify.** 29 languages, a scan with a strict score, then a fix loop driven by your coding agent. Its license is unclear, so check it before adopting.
- **Single-language linters.** eslint-plugin-slop for JavaScript and TypeScript, ex_slop for Elixir, and sloppy for PHP.
