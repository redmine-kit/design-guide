# Redmine 7 themes

How Redmine 7 finds, loads and applies a theme. Everything on this page was checked in the source of Redmine 7.0.3 (mainly `lib/redmine/themes.rb`, `lib/redmine/asset_path.rb`, `app/helpers/application_helper.rb`, `app/helpers/icons_helper.rb` and `app/views/layouts/base.html.erb`), and the behaviour was checked with a test theme in Redmine 7.0.3 in development mode.

## Where themes are

Redmine looks for themes in two directories:

| Directory | Contents |
| --- | --- |
| `themes/<id>/` | Themes that you install |
| `app/assets/themes/<id>/` | The themes that come with Redmine: `alternate` and `classic` |

A directory is a theme only when it has `stylesheets/application.css`.

| Item | Details |
| --- | --- |
| Id | The directory name, for example `my_theme`. Redmine stores it in the "Theme" setting (Administration » Settings » Display, the `ui_theme` setting) |
| Name | The directory name, humanized: `my_theme` becomes "My theme". Themes are sorted by name in the settings |
| Default | An empty setting means Redmine's own stylesheets without a theme |

## Directory layout

```text
themes/my_theme/
├── stylesheets/
│   ├── application.css   # required
│   └── gantt.css         # optional: replaces Redmine's gantt.css
├── javascripts/
│   └── theme.js          # optional: loaded on every page
├── images/
│   ├── icons.svg         # optional: replaces icons of Redmine's sprite
│   └── logo.png
├── favicon/
│   └── favicon.png       # optional: the favicon
├── fonts/                # any other directory is served too
└── src/                  # not served: sources such as Sass files
```

Every directory of the theme is served as assets, except `src/` and directories whose names start with `.`.

## How files are served

Redmine 7 serves assets with Propshaft. The files of each directory of a theme are served under `themes/<id>/`, **without the directory name**, and with a digest in the URL:

| File | Logical path | URL |
| --- | --- | --- |
| `stylesheets/application.css` | `themes/my_theme/application.css` | `/assets/themes/my_theme/application-<digest>.css` |
| `images/logo.png` | `themes/my_theme/logo.png` | `/assets/themes/my_theme/logo-<digest>.png` |
| `images/sub/bg.png` | `themes/my_theme/sub/bg.png` | `/assets/themes/my_theme/sub/bg-<digest>.png` |
| `fonts/body.woff2` | `themes/my_theme/body.woff2` | `/assets/themes/my_theme/body-<digest>.woff2` |

- Two files with the same name in different directories (for example `images/a.png` and `fonts/a.png`) get the same logical path. Keep file names unique across the directories of a theme.
- Files in `src/` are not served.

## Stylesheets

### application.css

Redmine's layout links its stylesheets in this order:

```erb
<%= stylesheet_link_tag 'jquery/jquery-ui-1.13.2', 'tribute-5.1.3', 'application', 'dropdown', 'responsive', :media => 'all' %>
```

When a theme is chosen, Redmine links the theme's file instead of its own for every name that the theme has in `stylesheets/`. The theme's `application.css` therefore **replaces** Redmine's `application.css`. To build on Redmine's styles, import them first, as the built-in themes do:

```css
@import url(/application.css);

#header { background: #2f6596; }
```

### Colors and fonts

Redmine's `application.css` imports `open-color.css` ([Open Color](https://yeun.github.io/open-color/) 1.9.1) and defines a few custom properties on `:root`. A theme can set them in its `application.css`, after the `@import`:

| Custom property | Default | Used for |
| --- | --- | --- |
| `--fonts-main` | `"Noto Sans", sans-serif` | The text of the pages |
| `--color-header-background` | `#3A78A3` | The header |
| `--color-top-menu-background` | `#234761` | The top menu |
| `--color-current-marker` | `var(--oc-indigo-5)` | The marker of the current item |
| `--oc-<color>-<0-9>` | Open Color | Most other colors of Redmine's stylesheets, for example `--oc-gray-5` |

Every variable, its value and the role core gives it are on the [Colors](colors.md) page.

Redmine 7 comes with the Noto Sans font (regular, bold, italic and bold italic).

```css
@import url(/application.css);

:root {
  --color-header-background: #2f6596;
  --color-top-menu-background: #1f4a70;
}
```

### Other stylesheets

These stylesheets are linked by name and can be replaced in the same way:

| Name | Where Redmine links it |
| --- | --- |
| `application` | Every page |
| `dropdown` | Every page |
| `responsive` | Every page |
| `tribute-5.1.3` | Every page (mentions) |
| `context_menu` | Pages with the context menu of issues and spent time |
| `jstoolbar` | Pages with the wiki toolbar |
| `gantt` | The Gantt chart |
| `scm` | Repository pages, diffs, file views, wiki annotate and news pages |

These cannot be replaced by a theme:

- `jquery/jquery-ui-1.13.2`: it is linked with a directory in its name, which never matches a file of the theme.
- `wiki_syntax.css` and `wiki_syntax_detailed.css` (the wiki syntax help): the help pages are standalone HTML pages without Redmine's layout (checked: `HelpController` renders them with `layout: nil`). They link only these files, with the `.css` extension, and link neither `application.css` nor the theme, so a theme cannot style them.

Stylesheets of plugins are linked with their plugin's name and are not replaced by a theme either. Override them with more specific selectors.

### url() in stylesheets

Redmine rewrites the `url()` references in the theme's stylesheets to the served URLs with digests. These forms work (checked):

```css
@import url(/application.css);                         /* Redmine's own stylesheet */
#header { background: url(../images/header.png); }     /* relative to the stylesheet */
#footer { background: url(/themes/my_theme/bg.png); }  /* the logical path */
@font-face { font-family: Body; src: url(../fonts/body.woff2); }
```

### legacy-icons-compat.css

Redmine 7 removed the old raster icons. `legacy-icons-compat.css` restores their look for plugins that have not moved to SVG icons. It is not linked by default; a plugin or theme imports it with `@import url('/legacy-icons-compat.css');`. Redmine says it will be removed in a future version.

## JavaScript

When the theme has `javascripts/theme.js`, Redmine links it on every page, in `<head>`, after Redmine's own scripts (jQuery, Rails UJS, Tribute, `application-legacy.js` and `responsive.js`) and before the page's own tags. It is a classic script, not a module. Other files in `javascripts/` are served but not linked.

## Images

Redmine's `image_tag` uses the theme's image when `images/` has a file with the same name, for example `images/logo.png` for `image_tag('logo.png')`. Images in stylesheets are referenced with `url()` (see above).

## Icons

Redmine 7 draws icons from an SVG sprite, `icons.svg`, made from [Tabler Icons](https://tabler.io/icons) 3.43.0. Each icon is a `<symbol>` with the id `icon--<name>`, for example `icon--edit`, and is drawn with:

```html
<svg class="s18 icon-svg" aria-hidden="true"><use href="/assets/icons-<digest>.svg#icon--edit"></use></svg>
```

A theme can replace icons with its own `images/icons.svg`. Redmine decides **per icon**: an icon whose id is in the theme's sprite comes from the theme's sprite, and every other icon still comes from Redmine's sprite. A theme can therefore replace only some icons:

```xml
<svg xmlns="http://www.w3.org/2000/svg">
  <defs>
    <symbol viewBox="0 0 24 24" id="icon--edit">
      <path d="..."/>
    </symbol>
  </defs>
</svg>
```

- Redmine's stylesheet draws `svg.icon-svg` with `stroke` and `fill: none` (stroke width 1.5), the style of Tabler's outline icons. Draw replacement icons for that style, or change these styles in the theme's CSS.
- The [Icons (SVG sprite)](https://redmine-kit.github.io/redmine_lookbook/previews.html#basics) preview shows every icon of Redmine's sprite.
- Plugins can have their own sprites; a theme does not replace them.

## Favicon

When the theme has files in `favicon/`, Redmine uses the first file it finds there as the favicon. Put only one file in `favicon/`.

## Classes on body

`<body>` gets these classes, which a theme can use to style pages:

| Class | When |
| --- | --- |
| `theme-<Name>` | A theme is chosen. The name with spaces replaced by `_`, for example `theme-My_theme` |
| `project-<identifier>` | The page belongs to a project |
| `has-main-menu` | The page shows the project menu |
| `controller-<name>` | Always, for example `controller-issues` |
| `action-<name>` | Always, for example `action-show` |
| `textarea-<font>` | The user chose a font for text areas (`monospace` or `proportional`) in their preferences |

`<body>` also has `data-text-formatting` with the text formatting setting (`common_mark` by default in Redmine 7).

`<html>` has `lang` (the user's language) and `dir` (`ltr`, or `rtl` for Arabic, Persian and Hebrew).

## Page structure

The main elements of Redmine's layout (`base.html.erb`):

| Element | Contents |
| --- | --- |
| `#wrapper` | Everything |
| `.flyout-menu` | The menu for narrow screens |
| `#top-menu` | The top menu and `#account` (sign in, my account) |
| `#header` | `#quick-search`, `#project-jump`, the title and `#main-menu` (the project menu) |
| `#main` | `#sidebar` and `#content`. `#main` has the class `collapsiblesidebar`, or `nosidebar` when the page has no sidebar |
| `#footer` | "Powered by Redmine" |
| `#ajax-indicator`<br>`#ajax-modal` | The loading indicator and the dialog |

## Right-to-left languages

For Arabic, Persian and Hebrew, `<html>` has `dir="rtl"`. Redmine's stylesheets use logical properties (`margin-inline-start`, `inset-inline-end` and so on) in many places, so that the layout follows the direction. Use logical properties in a theme as well, and check it with the language option of the toolbar.

## Narrow screens

`responsive.css` changes the layout below 900 pixels wide: the header becomes a fixed bar, and the top menu, the project menu and the sidebar move to the flyout menu (`.flyout-menu`), which the button in the header opens. `application.css` also sets the width of the sidebar for several screen widths.

## Printing

`application.css` has print styles (`@media print`): the top menu, the header, the project menu, the sidebar, the footer, `.contextual` links and the links to other formats are hidden, and elements with the `hide-when-print` class too.

## Dark mode

Redmine's stylesheets do not have dark styles (`prefers-color-scheme`). A theme that supports dark mode adds its own.

## Emails

Themes do not apply to emails. Redmine's email layout has its own styles in a `<style>` element.

## Restart and reload

| Item | Details |
| --- | --- |
| New theme | Restart Redmine. Redmine finds a new theme in the settings without a restart, but registers the files of themes for serving when it starts, so the new theme's files are not found (HTTP 404) until a restart (checked) |
| Adding or removing files | Restart Redmine. Redmine keeps the list of a theme's stylesheets, scripts, images and favicons in memory |
| Editing files | Reload the page. In development mode, Redmine serves the changed file with a new digest (checked) |
