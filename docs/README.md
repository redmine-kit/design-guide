# Redmine Design Guide

How Redmine 7's own screens are built, for plugin screens that look and behave like core, and how Redmine 7 applies a theme, for theme authors. The patterns are taken from Redmine 7.0.3: each one names the core views that use it, the markup and helpers to copy, and what Redmine's default stylesheet (`app/assets/stylesheets/application.css`) does with its classes.

## Screens

The approach: before writing a screen, pick the core screen of the same kind and write the view after it. With the same markup, helpers and classes, Redmine's default stylesheet lays the screen out, and themes style it as they style core. Add a class or a little CSS only where core has no pattern.

| Kind of screen | Core screen to follow | Page |
| --- | --- | --- |
| Page title, actions at the top right, sections | Administration › Users, the role form | [Page structure](page.md) |
| A list of records with actions | Administration › Enumerations | [Lists](lists.md) |
| Values and checks to show | Administration › Information | [Information](information.md) |
| Settings in tabs | Administration › Settings | [Settings](settings.md) |
| A form to create or edit a record | New issue, the tracker form | [Forms](forms.md) |
| Notices, errors, warnings, empty states | Saving settings, a form with errors, an empty list | [Messages](messages.md) |
| Icons, action links, delete links | Throughout | [Icons and links](icons-and-links.md) |
| A tab of a project's settings | Project › Settings | [Project settings](project-settings.md) |

Where no core screen fits, see [When core has no pattern](no-pattern.md).

## Themes

- [Redmine 7 themes](themes.md): how Redmine 7 finds, loads and applies a theme, and what a theme can change
- [Theme checklist](theme-checklist.md): what a theme has to handle, with the [Redmine Lookbook](https://redmine-kit.github.io/redmine_lookbook/) preview to check each item

## Screenshots

The screenshots are Redmine 7.0.3 as released, with Redmine's test data, at 1280 px wide (the content area), in English and Japanese. `bin/screenshots` takes them again in Docker (Redmine 7.0.3, PostgreSQL 16 and headless Chromium; `test/screens.rb` lists the screens):

```sh
bin/screenshots
```

The two images of the theme checklist (the context menu and the Git revisions) are previews of Redmine Lookbook.

Redmine is a trademark of Jean-Philippe Lang. This guide quotes Redmine's code (GPL-2.0) to show its patterns.

## Sponsors

<Sponsors ids="keyselect"><a href="https://www.keyselect.co.jp/">KEY SELECT</a></Sponsors>

## License

Redmine Design Guide is released under the GNU General Public License, version 2 or (at your option) any later version. See [LICENSE](../LICENSE). An unofficial project for Redmine.
