# When core has no pattern

The approach of this guide: follow core wherever a core screen of the same kind exists. It is an approach, not an absolute rule.

- **First look for the closest core screen.** Most screens are a combination of the patterns here: a title and actions, sections, lists, settings, forms and messages. A screen that looks new usually is one of them with different content.
- **When nothing fits,** add what is missing, with a reason:
  - a class next to core's classes, named after what it is (for example a type class on `table.list`, as core does with `enumerations`), so that themes can reach it;
  - a little CSS, scoped to the plugin's own elements, using core's CSS variables (`--oc-gray-4` and the others in `application.css`) so that themes and dark styles follow;
  - the reason in the commit message or the plugin's documentation.
- **Do not restyle core's elements** (`.box`, `table.list`, `.tabular`, headings) for one screen. If the default does not fit, the markup is usually not the core pattern yet.
- **Check the result** against the core screen it follows: screenshots at the same width, in English and Japanese, and the spacing between sections.
- **When a new kind of screen is needed,** add its pattern here.
