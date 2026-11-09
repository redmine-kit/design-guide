# Building a screen with no matching pattern

This guide follows core wherever a core screen of the same kind exists. That is an approach, not an absolute rule: when no core screen fits, you add what is missing, and you say why.

## Look for the closest core screen first

Most screens turn out to be a combination of the patterns in this guide: a title with actions, sections, lists, settings, forms and messages. A screen that looks new is usually one of them with different content, so start from the closest core screen and change only the content.

## Add only what is missing

When no pattern fits, add the smallest thing that does the job.

| What to add | How |
| --- | --- |
| A class | Next to core's classes, named after what the element is, so that themes can reach it. Core does the same with `enumerations` on its `table.list`. |
| CSS | A little, scoped to the plugin's own elements. Use core's CSS variables (`--oc-gray-4` and the others in `application.css`) so that themes and dark styles follow. |

Write the reason in the commit message or in the plugin's documentation.

## Keep core's elements as they are

Don't restyle core's elements (`.box`, `table.list`, `.tabular`, headings) for one screen. When the default style doesn't fit, the markup is usually not following the core pattern yet; fix the markup instead.

## Compare with the core screen

Take screenshots of your screen and of the core screen it follows at the same width, in English and Japanese, and compare them, including the spacing between sections.

## Add the pattern here

When a new kind of screen is needed, add its pattern to this guide so that the next screen can follow it.
