---
name: snowflake-bcr-assessment
description: Use when a Snowflake Behavior Change Bundle Release Announcement is received, to assess each announced bundle's relevance and impact for our concrete Snowflake setup.
---

# Snowflake BCR bundle assessment

Assess each change in the announced behavior change bundle(s) against our
actual environment, and report which changes affect us, why, and how urgent
they are. Determine relevance by checking our setup live, not from memory.

## Input

The pasted Snowflake announcement email. From the email itself, extract:

- The bundle name(s) it announces (e.g. `2026_05`).
- Each bundle's per-account status (e.g. *disabled by default* / *enabled by
  default* / *generally enabled*). Read this from the email every time; it
  changes per release and per account.

If the email is not pasted, ask for it before proceeding.

## Environment

- **Query Snowflake only via:** `snow sql --connection de --format json --query "<query>"`.
  Never use a Python connector, JDBC, or any other method. If `snow sql` fails
  or is insufficient, stop and ask how to proceed.
- **Repos to grep**:
  - `/home/wout/dev/dwh/custom-data-loaders`
  - `/home/wout/dev/dwh/infrastructure`
  - `/home/wout/dev/dwh/py-data-shared-dev`
  - `/home/wout/dev/dwh/py-data-shared`
  - `/home/wout/dev/dwh/pytransforms`
  - `/home/wout/dev/dwh/transformations`
- **Cost lens:** our footprint is small and cost-sensitive. Always flag any
  change to a default that affects cost or performance, even if low-risk.
- **Reference URLs:**
  - Bundle index: `https://docs.snowflake.com/en/release-notes/behavior-changes`
  - Bundle detail: `https://docs.snowflake.com/en/release-notes/bcr-bundles/<bundle>_bundle`
    (e.g. `.../bcr-bundles/2026_05_bundle`)

## Procedure

1. Parse the email into the bundle name(s) and each bundle's status.
2. For each bundle, fetch its detail page and enumerate every individual
   change (title + functional area + what changes / what could break).
3. For each change, decide relevance to us:
   a. Derive the feature or risk pattern the change concerns (e.g. Iceberg,
      replication, `CREATE OR ALTER FUNCTION`, positional `SHOW` parsing,
      warehouse generation/QAS defaults, a view gaining a column).
   b. Recheck that pattern **live** against our setup: grep the repos above
      for the relevant SQL/config, and/or run `snow sql` to inspect account
      state (e.g. `show warehouses`, `show ...`, information_schema). Do not
      assume we do or do not use something; verify it.
   c. Conclude: does it affect us, and why (cite the grep hit or query result).
4. Produce the report.

The read-only checks in step 3 (grep, `snow sql`, doc fetches) run
automatically without asking.

## Output (chat only)

- A per-change verdict table: `change | bundle | affects us? | why (evidence)`.
- Urgency framing derived from the statuses: opt-in to test (disabled by
  default), opt-out window open (enabled by default), or already live with no
  opt-out (generally enabled).
- Any deliberate decisions or actions warranted, as **optional suggested
  edits only** — describe what could be changed and where (e.g. a Terraform
  setting). Do not apply edits, and do not perform gated edits; the skill
  assesses and suggests, nothing more.
