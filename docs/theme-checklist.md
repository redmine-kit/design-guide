# Theme checklist

What a Redmine 7 theme has to handle, and the previews of [Redmine Lookbook](https://redmine-kit.github.io/redmine_lookbook/) to check each item with. The previews are named as in Lookbook's navigation (see the [preview list](https://redmine-kit.github.io/redmine_lookbook/previews.html)). For how Redmine applies a theme, see [Redmine 7 themes](themes.md).

Check each item with the defaults of Lookbook's toolbar first ([using the previews](https://redmine-kit.github.io/redmine_lookbook/usage.html)), then with:

- the "Redmine layout" option, for the header, the menus and the sidebar,
- a right-to-left language (Arabic, Persian or Hebrew),
- a language with long words (for example German) and a language in a non-Latin script (for example Japanese),
- a narrow preview pane (below 900 pixels wide), for `responsive.css`.

## Setup

| Item | What to check | Previews |
| --- | --- | --- |
| Redmine's styles | `application.css` imports Redmine's `application.css` or replaces all of it | Any |
| Colors and fonts | The custom properties (`--color-header-background`, `--fonts-main`, Open Color's `--oc-*`) give the colors you want | Pages » Projects » Project overview |
| Replaced stylesheets | `gantt.css`, `context_menu.css`, `jstoolbar.css`, `scm.css`, `dropdown.css` and `responsive.css` of the theme, if any, cover what Redmine's files cover | Gantt chart, Context menu, Text area with the wiki toolbar, Diff; Menus; Layout » Whole layout with the flyout menu open (narrow screens) |
| Favicon and `theme.js` | The favicon shows, and `theme.js` has no errors in the browser console | Any page with the Redmine layout |

## Layout

| Item | What to check | Previews |
| --- | --- | --- |
| Whole layout | All parts together: with and without a project, signed out, a closed project | Layout » Whole layout, Whole layout without a project, Whole layout, signed out, Whole layout of a closed project |
| Top menu and account menu | Links, the avatar, the account menu open, signed in and signed out | Layout » Top menu, Top menu with the account menu open, Top menu, signed out |
| Header | Title, quick search, "Jump to a project" closed and open | Layout » Header with the project menu; Menus » Jump to a project, open |
| Project menu | Tabs, the selected tab, many modules, the "+" menu | Project menu; Menus » New object menu ("+") in the project menu, open |
| Sidebar | Width, links, the selected link, sidebar forms, hidden | Layout » Sidebar, Whole layout with the sidebar hidden; Issue sidebar |
| Content | Title and breadcrumbs, `.contextual` links, splitcontent | Title with breadcrumbs; Pages » Projects » Project overview |
| No sidebar | `#main.nosidebar` | Pages » Issues » New issue |
| Footer | | Layout » Footer |
| Narrow screens | The header bar, the flyout menu, tables that scroll | Layout » Whole layout with the flyout menu open (narrow screens), with a narrow pane; any page with the Redmine layout |
| Printing | Menus and controls are hidden | Any page, in the browser's print preview |

## Navigation

The "Menus" previews show menus open, for example the context menu of the issue list:

![The context menu of the issue list, open](images/context-menu.png)

| Item | What to check | Previews |
| --- | --- | --- |
| Tabs | Selected, many tabs (scroll buttons) | Tabs; Menus » Tabs with scroll buttons; Pages » Settings |
| Menus | Dropdowns open: actions, context menu, account | Menus |
| Administration menu | Icons and the selected item | Administration menu; Pages » Administration » Administration |
| Pagination | Current page, per page | Pagination |

## Basic elements

| Item | What to check | Previews |
| --- | --- | --- |
| Colors | The variables the theme redefines, the role colors (text, links, borders, flash messages, list rows), contrast ([Colors](colors.md#contrast)) | Color palette |
| Text | Headings, paragraphs, links, lists, code outside wiki content | Headings and text |
| Flash messages | Notice, warning and error | Flash messages |
| Notices | Warnings, conflicts, empty lists | Notices and empty states |
| Buttons and links | Buttons, icon links, disabled | Buttons and icon links |
| Badges | Private, closed, locked and others | Badges |
| Icons | Every icon of the sprite, sizes, icons next to text | Icons (SVG sprite) |
| Avatars and users | Sizes, user links, groups | Avatars and user links |
| Progress bars | Done and closed parts, legends | Progress bar; Pages » Projects » Roadmap |
| Tables | `table.list`, odd and even rows, selected rows, sorting, empty lists | Tables; Issue list |
| Boxes | `.box`, fieldsets, collapsible fieldsets | Boxes and fieldsets |
| Modal dialogs | The dialog, its title and buttons | Modal dialog |
| Tooltips | The issue tooltip | Issue tooltip |

## Forms

| Item | What to check | Previews |
| --- | --- | --- |
| Fields | Text, select, check boxes, radio buttons, dates, required fields, help text | Form fields; Pages » Issues » New issue |
| Errors | The error box and fields with errors | Error messages |
| File upload | The file field and the list of added files | File upload field; Pages » Issues » Edit attachments |
| Wiki toolbar | The toolbar, the preview tab, the text area fonts | Text area with the wiki toolbar; Pages » Content » Wiki edit |
| Filters | Filters, options, the "Apply" and "Clear" links | Issue filters; Pages » Issues » New query |
| Large forms | Tabular forms and tabs | Pages » Settings; Pages » Administration » Edit role, Workflow |

## Issues

| Item | What to check | Previews |
| --- | --- | --- |
| Issue list | Columns, priorities and statuses as classes, grouped rows, totals, descriptions in rows, empty lists, the context menu | Issue list; Menus » Context menu of the issue list, open; Pages » Issues » Issues, Issues grouped, with totals, Issues with description and last notes, Issues: nothing found |
| Issue page | Attributes, description, the sticky header, private and closed issues | Pages » Issues » Issue, Closed issue, Private issue |
| History | Notes, changes, reactions | History; Pages » Issues » Issue |
| Attachments | File list, thumbnails | Attachments |
| Related issues and subtasks | The tables and their buttons | Related issues; Subtasks; Pages » Issues » Issue with related issues |
| Associated revisions | The revisions of an issue | Pages » Issues » Issue with associated revisions |
| Watchers and custom fields | | Watchers; Custom fields |

## Planning

| Item | What to check | Previews |
| --- | --- | --- |
| Gantt chart | Bars, versions, today's line, relations | Pages » Issues » Gantt chart |
| Calendar | Days, today, issues that start and end | Calendar; Pages » Issues » Calendar |
| Roadmap and versions | Version overview, progress | Version overview; Pages » Projects » Roadmap, Version |
| Spent time | List and report | Pages » Issues » Spent time, Spent time report |

## Content

| Item | What to check | Previews |
| --- | --- | --- |
| Wiki formatting | Headings, lists, tables, code and syntax highlighting, quotes, alerts, footnotes, task lists, images, macros, links to Redmine objects. Check both formats | Wiki formatting (`format` parameter); Pages » Content |
| Wiki pages | Sections with edit links, history, diff, annotate, index | Pages » Content » Wiki page with sections, Wiki history, Wiki diff, Wiki annotate, Wiki index |
| Diffs | Inline and side by side | Diff; Pages » Content » Wiki diff; Pages » Issues » Description diff |
| Source files | Line numbers and syntax highlighting | Source file with syntax highlighting; Pages » Content » Attachment: source file |
| Attachments | Text, diff, image and other files | Pages » Content » Attachment: source file, Attachment: diff, Attachment: image, Attachment: other file |
| News, documents, files and forums | Lists, comments, replies | News; Pages » Content |
| Activity | Days, event icons | Activity; Pages » Projects » Activity |
| Members | Roles and members | Members |

## Repositories

The repository previews use the test repositories of Redmine's own tests:

![The revisions of the Git test repository with the revision graph](images/repository.png)

| Item | What to check | Previews |
| --- | --- | --- |
| Browser | Directories, files, the last revision of each, several repositories in the sidebar | Pages » Repository » Repository, Directory, Git repository, Git directory |
| Files | Line numbers and syntax highlighting, text, images, annotate, the history of a file | Pages » Repository » File with syntax highlighting, Text file, Image file, Annotate, File history |
| Revisions | The list with the revision graph, branches, a revision with its changes and related issues | Pages » Repository » Revisions, Git revisions with the graph, Mercurial revisions with branches, Revision with related issues, Git revision with every kind of change |
| Diffs | Inline and side by side | Pages » Repository » Revision diff, Revision diff, side by side, Git revision diff |
| Statistics | The charts | Pages » Repository » Statistics |
| Settings | New and edit forms, the project settings tab | Pages » Repository » New repository, Edit repository, Project settings: repositories |

## Pages

| Item | What to check | Previews |
| --- | --- | --- |
| Signed out | Sign in, lost password, register, pages of a public project | Pages » Account; Pages » Projects » Project overview, signed out; Pages » Issues » Issue, signed out |
| Password confirmation | The sudo mode form | Pages » Account » Confirm password (sudo mode) |
| Personal pages | My page blocks, my account | Pages » Account » My page, My account |
| Administration | Lists, forms with tabs, webhooks, the information page | Pages » Administration |
| Errors | 404, 403, sign-in required | Pages » Errors |
| Search | Results of all types | Pages » Projects » Search results (all types) |

## Not covered by the previews

Check these in a Redmine of your own:

- **States after JavaScript:** page previews are opened with a GET request and show pages as they first appear. The "Menus" previews show the menus open, but autocomplete lists (issues, wiki pages and mentions), drag and drop, and forms after they are sent are not shown.
- **Hover and focus:** check them by pointing at and tabbing through the previews.
- **Other users:** most page previews render as an administrator, who sees every link. Some render as `jsmith` (for example "Project overview as a member" and "Issue as a member"), `dlopper` ("Forbidden (403)") or an anonymous user (the signed-out pages). Check the pages that matter for your users with a user of their role.
- **Private notes:** Redmine's test data has no private notes.
- **Settings that change pages:** for example Gravatar, the text area font of a user, table sorting in wiki pages and disabled reactions. The previews use the settings of the test data, except where the preview list gives settings in "Notes". Your own previews can set others (see [Writing previews](https://redmine-kit.github.io/redmine_lookbook/writing-previews.html#settings-for-one-preview)).
- **Plugins:** pages and stylesheets of plugins. Add [your own previews](https://redmine-kit.github.io/redmine_lookbook/writing-previews.html) for them.
- **Emails, PDF and CSV exports, Atom feeds and the wiki syntax help:** themes do not apply to them (see [Redmine 7 themes](themes.md#other-stylesheets) for the help pages).
