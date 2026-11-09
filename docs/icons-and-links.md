# Icons and links

Icons come from one SVG sprite, and actions are links with an icon. Use the same helpers as core so that themes can replace the icons and style the links.

## Icons

`sprite_icon(name, label = nil, …)` writes an inline SVG that uses a symbol of the sprite (`app/assets/images/icons.svg`, 118 icons in 7.0.3; their sources are listed in `config/icon_source.yml`):

```html
<svg class="s18 icon-svg"><use href="/assets/icons-….svg#icon--add"></use></svg><span class="icon-label">New value</span>
```

| Item | Details |
| --- | --- |
| Size | 18px by default (`size:`); the class is `s<size>` |
| Filled | `style: :filled` adds `icon-svg-filled` |
| Right to left | `rtl: true` mirrors arrows in right-to-left languages |
| Only the icon | `icon_only: true` gives the label the `hidden` class; give the link the class `icon-only` and a `title`, as `reorder_handle` and `toggle_checkboxes_link` do |
| A theme's icons | When the current theme has a sprite with the icon, `sprite_icon` uses the theme's sprite ([Redmine 7 themes](themes.md)) |
| A plugin's icons | `sprite_icon('name', plugin: :my_plugin)` uses the sprite `icons.svg` of the plugin's assets (`plugin_assets/my_plugin/icons.svg`). Use core's icons where one fits |

`.icon` and `.icon-only` lay the icon and the label out in a row; links color the icon on hover.

## Action links

An action is a link with an icon and the classes `icon icon-<name>`. In `.contextual` at the top right of the page, or in a `<p>` above a list ([Lists](lists.md)). From `app/views/enumerations/index.html.erb`:

```erb
<p><%= link_to sprite_icon('add', l(:label_enumeration_new)), new_enumeration_path(:type => klass.name), :class => 'icon icon-add' %></p>
```

| Action | Icon | Classes | Label |
| --- | --- | --- | --- |
| Add | `add` | `icon icon-add` | `label_<thing>_new` |
| Edit | `edit` | `icon icon-edit` | `button_edit` |
| Copy | `copy` | `icon icon-copy` | `button_copy` |
| Delete | `del` (with `delete_link`) | `icon icon-del` | `button_delete` |
| Test a connection | `arrow-right` | `icon icon-test` | `button_test` |

- An action that changes data uses `:method => :post` (or `:delete`), as `link_to l(:label_send_test_email), test_email_path, :method => :post` does.
- A link that runs a script uses `link_to_function`.

## Delete links

`delete_link(url)` writes the delete action with a confirmation (`text_are_you_sure`) and `:method => :delete`:

```erb
<%= delete_link enumeration_path(enumeration) %>
```

`remove_link(url)` is the same for removing a link between records (`icon-link-break`, `button_remove`).

## Actions in a row

The actions on a row of a list go in `td.buttons` (end-aligned, no wrapping, `0.6em` between links). In core the sort handle (`reorder_handle`) comes first and delete last, with other actions between them (Custom fields: sort, copy, delete) ([Lists](lists.md#columns)).

## Checking many checkboxes

- `check_all_links('form_id')`: "Check all | Uncheck all" links for every checkbox of a form or element (Settings › Email notifications).
- `toggle_checkboxes_link(selector)`: a check icon that toggles the checkboxes, put in a `legend` or a header cell (the tracker form, the role form's permissions).

## Yes and no

`checked_image(value)` shows the check icon (`span.icon-only.icon-checked`) for true and nothing for false; put it in `td.tick`. For a check that can fail, use `icon-ok` (green) and `icon-error` (red) as on Administration › Information ([Information](information.md)).
