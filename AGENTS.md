# AGENTS.md

Guidelines for people and coding agents working in this repository. See [README.md](README.md) for an overview and [docs/](docs/README.md) for the guide.

## What this repository is

The Redmine Design Guide: the patterns of Redmine's own screens, for plugin screens that follow core, and how Redmine applies a theme, for theme authors. The organization's repositories follow it when they build screens (the org-level AGENTS.md next to the repositories points here).

## Rules

- **From Redmine's own code.** Every pattern names the core views that use it and quotes their markup; every style value comes from Redmine's stylesheets. Check them against the Redmine version the guide is written for (7.0.3 now), and update them when a new Redmine release changes them.
- **An approach, not absolute rules.** Write "follow core where it can be followed" and how to handle what core does not cover, not "always" or "never".
- **Screenshots are core as released.** `bin/screenshots` takes them from Redmine 7.0.3 with Redmine's test data (`test/screens.rb`). Look at every image before committing: no error text, the screen the page describes, English in `docs/images/`, Japanese in `docs/ja/images/`.
- **Themes and Lookbook.** The theme pages link to Redmine Lookbook's previews with absolute URLs; Lookbook's own docs stay in redmine_lookbook.
- **No secrets in the repository.**

## Documentation

- **Two languages.** English is the source (`README.md`, `docs/`); the Japanese translation is `README.ja.md` and `docs/ja/`, with the same file names. Change both together.
- **Layout.** The README stays short. The guide is in `docs/`, published at https://redmine-kit.github.io/design-guide/ with [redmine-kit/docs-skeleton](https://github.com/redmine-kit/docs-skeleton).
- **Anchors in Japanese.** Put `<a id="..."></a>` with the English heading's anchor before each Japanese heading.
- **Commands** to run go in `sh` blocks, with a sentence that says what they do.
- **Japanese wording.** Plain, precise Japanese. Keep established technical terms. Do not use "版" for a version; write "通知" rather than "知らせ", "確認" rather than "確かめる", "コピー" rather than "写す", "インストール" rather than "入れ方".

## Commits

- English, imperative mood, 72 characters or fewer in the first line, no trailing period.
- One purpose per commit.
- Do not rewrite pushed history.
