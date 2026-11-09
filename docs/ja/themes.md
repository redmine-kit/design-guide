# Redmine 7 のテーマ

Redmine 7 がテーマを見つけ、読み込み、適用する仕組みです。このページの内容は、Redmine 7.0.3 のソース(主に `lib/redmine/themes.rb`、`lib/redmine/asset_path.rb`、`app/helpers/application_helper.rb`、`app/helpers/icons_helper.rb`、`app/views/layouts/base.html.erb`)で確認し、動作は開発モードの Redmine 7.0.3 とテスト用のテーマで確認しました。

<a id="where-themes-are"></a>

## テーマの場所

Redmine は、2 つのディレクトリからテーマを探します。

| ディレクトリ | 内容 |
| --- | --- |
| `themes/<id>/` | インストールしたテーマ |
| `app/assets/themes/<id>/` | Redmine に付属するテーマ: `alternate` と `classic` |

ディレクトリは、`stylesheets/application.css` があるときだけテーマになります。

- **id:** ディレクトリの名前です(たとえば `my_theme`)。Redmine は、これを「テーマ」の設定(管理 » 設定 » 表示、`ui_theme` の設定)に保存します。
- **名前:** ディレクトリの名前を読みやすくしたものです。`my_theme` は「My theme」になります。設定の画面では、テーマは名前の順に並びます。
- **既定:** 設定が空のときは、テーマを使わず、Redmine 自身の CSS だけを使います。

<a id="directory-layout"></a>

## ディレクトリの構成

```text
themes/my_theme/
├── stylesheets/
│   ├── application.css   # 必須
│   └── gantt.css         # 任意: Redmine の gantt.css を置き換える
├── javascripts/
│   └── theme.js          # 任意: すべての画面で読み込む
├── images/
│   ├── icons.svg         # 任意: Redmine のスプライトのアイコンを置き換える
│   └── logo.png
├── favicon/
│   └── favicon.png       # 任意: ファビコン
├── fonts/                # ほかのディレクトリも配信される
└── src/                  # 配信されない: Sass のファイルなどのソース
```

テーマのディレクトリは、`src/` と、名前が `.` で始まるディレクトリを除いて、すべてアセットとして配信されます。

<a id="how-files-are-served"></a>

## ファイルの配信

Redmine 7 は、Propshaft でアセットを配信します。テーマの各ディレクトリのファイルは、`themes/<id>/` の下に、**ディレクトリの名前を除いて**、URL にダイジェストを付けて配信されます。

| ファイル | 論理パス | URL |
| --- | --- | --- |
| `stylesheets/application.css` | `themes/my_theme/application.css` | `/assets/themes/my_theme/application-<digest>.css` |
| `images/logo.png` | `themes/my_theme/logo.png` | `/assets/themes/my_theme/logo-<digest>.png` |
| `images/sub/bg.png` | `themes/my_theme/sub/bg.png` | `/assets/themes/my_theme/sub/bg-<digest>.png` |
| `fonts/body.woff2` | `themes/my_theme/body.woff2` | `/assets/themes/my_theme/body-<digest>.woff2` |

- 別のディレクトリにある同じ名前のファイル(たとえば `images/a.png` と `fonts/a.png`)は、同じ論理パスになります。ファイルの名前は、テーマのディレクトリ全体で重ならないようにしてください。
- `src/` のファイルは配信されません。

<a id="stylesheets"></a>

## スタイルシート

<a id="applicationcss"></a>

### application.css

Redmine のレイアウトは、スタイルシートを次の順に読み込みます。

```erb
<%= stylesheet_link_tag 'jquery/jquery-ui-1.13.2', 'tribute-5.1.3', 'application', 'dropdown', 'responsive', :media => 'all' %>
```

テーマを選ぶと、Redmine は、テーマの `stylesheets/` に同じ名前のファイルがあるものについて、自身のファイルの代わりにテーマのファイルを読み込みます。そのため、テーマの `application.css` は Redmine の `application.css` を**置き換えます**。Redmine のスタイルの上に作るときは、付属のテーマと同じように、最初に Redmine の `application.css` を読み込みます。

```css
@import url(/application.css);

#header { background: #2f6596; }
```

<a id="colors-and-fonts"></a>

### 色とフォント

Redmine の `application.css` は、`open-color.css`([Open Color](https://yeun.github.io/open-color/) 1.9.1)を読み込み、`:root` にいくつかのカスタムプロパティを定義しています。テーマは、`application.css` の `@import` のあとで、これらを設定できます。

| カスタムプロパティ | 既定値 | 用途 |
| --- | --- | --- |
| `--fonts-main` | `"Noto Sans", sans-serif` | 画面の文字 |
| `--color-header-background` | `#3A78A3` | ヘッダー |
| `--color-top-menu-background` | `#234761` | トップメニュー |
| `--color-current-marker` | `var(--oc-indigo-5)` | 選択中の項目の目印 |
| `--oc-<色>-<0-9>` | Open Color | Redmine の CSS のほとんどの色(たとえば `--oc-gray-5`) |

Redmine 7 には、Noto Sans のフォント(標準、太字、斜体、太字の斜体)が付属しています。

```css
@import url(/application.css);

:root {
  --color-header-background: #2f6596;
  --color-top-menu-background: #1f4a70;
}
```

<a id="other-stylesheets"></a>

### ほかのスタイルシート

次のスタイルシートは名前で読み込まれるので、同じ方法で置き換えられます。

| 名前 | Redmine が読み込む画面 |
| --- | --- |
| `application` | すべての画面 |
| `dropdown` | すべての画面 |
| `responsive` | すべての画面 |
| `tribute-5.1.3` | すべての画面(メンション) |
| `context_menu` | チケットと作業時間のコンテキストメニューがある画面 |
| `jstoolbar` | wiki のツールバーがある画面 |
| `gantt` | ガントチャート |
| `scm` | リポジトリの画面、差分、ファイルの表示、wiki のアノテート、ニュースの画面 |

次のものは、テーマで置き換えられません。

- `jquery/jquery-ui-1.13.2`: 名前にディレクトリが含まれるので、テーマのファイルと一致しません。
- `wiki_syntax.css` と `wiki_syntax_detailed.css`(wiki の書式のヘルプ): ヘルプの画面は Redmine のレイアウトを使わない独立した HTML です(確認済み: `HelpController` は `layout: nil` でレンダリングします)。拡張子 `.css` を付けてこれらだけを読み込み、`application.css` もテーマも読み込まないので、テーマではスタイルを変えられません。

プラグインのスタイルシートは、プラグインの名前を付けて読み込まれるので、これもテーマでは置き換えられません。詳細度の高いセレクターで上書きしてください。

<a id="url-in-stylesheets"></a>

### スタイルシートの url()

Redmine は、テーマのスタイルシートの `url()` の参照を、ダイジェストの付いた配信の URL に書き換えます。次の書き方が使えます(確認済み)。

```css
@import url(/application.css);                         /* Redmine 自身のスタイルシート */
#header { background: url(../images/header.png); }     /* スタイルシートからの相対パス */
#footer { background: url(/themes/my_theme/bg.png); }  /* 論理パス */
@font-face { font-family: Body; src: url(../fonts/body.woff2); }
```

<a id="legacy-icons-compatcss"></a>

### legacy-icons-compat.css

Redmine 7 では、古いラスター画像のアイコンが削除されました。`legacy-icons-compat.css` は、SVG のアイコンに移行していないプラグインのために、その見た目を戻します。既定では読み込まれず、プラグインやテーマが `@import url('/legacy-icons-compat.css');` で読み込みます。Redmine は、今後のバージョンで削除するとしています。

<a id="javascript"></a>

## JavaScript

テーマに `javascripts/theme.js` があると、Redmine はすべての画面の `<head>` で、Redmine 自身のスクリプト(jQuery、Rails UJS、Tribute、`application-legacy.js`、`responsive.js`)のあと、画面ごとのタグの前に読み込みます。モジュールではなく、通常のスクリプトです。`javascripts/` のほかのファイルは配信されますが、読み込まれません。

<a id="images"></a>

## 画像

Redmine の `image_tag` は、テーマの `images/` に同じ名前のファイルがあると、テーマの画像を使います。たとえば、`image_tag('logo.png')` には `images/logo.png` を使います。スタイルシートの画像は `url()` で参照します(上記)。

<a id="icons"></a>

## アイコン

Redmine 7 は、SVG のスプライト `icons.svg` からアイコンを描きます。スプライトは [Tabler Icons](https://tabler.io/icons) 3.43.0 から作られています。アイコンはそれぞれ `icon--<名前>` の id を持つ `<symbol>` で(たとえば `icon--edit`)、次のように描かれます。

```html
<svg class="s18 icon-svg" aria-hidden="true"><use href="/assets/icons-<digest>.svg#icon--edit"></use></svg>
```

テーマは、自身の `images/icons.svg` でアイコンを置き換えられます。Redmine は**アイコンごとに**判断します。テーマのスプライトに id があるアイコンはテーマのスプライトから、それ以外のアイコンは Redmine のスプライトから描きます。そのため、テーマは一部のアイコンだけを置き換えられます。

```xml
<svg xmlns="http://www.w3.org/2000/svg">
  <defs>
    <symbol viewBox="0 0 24 24" id="icon--edit">
      <path d="..."/>
    </symbol>
  </defs>
</svg>
```

- Redmine のスタイルシートは、`svg.icon-svg` を `stroke` と `fill: none`(線の幅 1.5)で描きます。これは Tabler の outline のアイコンのスタイルです。置き換えるアイコンはこのスタイルに合わせて描くか、テーマの CSS でこれらのスタイルを変えてください。
- [Icons (SVG sprite)](https://redmine-kit.github.io/redmine_lookbook/ja/previews.html#basics) のプレビューで、Redmine のスプライトのすべてのアイコンを確認できます。
- プラグインは自身のスプライトを持てます。テーマはそれを置き換えません。

<a id="favicon"></a>

## ファビコン

テーマの `favicon/` にファイルがあると、Redmine は、そこで最初に見つけたファイルをファビコンにします。`favicon/` には、ファイルを 1 つだけ置いてください。

<a id="classes-on-body"></a>

## body のクラス

`<body>` には次のクラスが付き、テーマは画面ごとのスタイルに使えます。

| クラス | 付くとき |
| --- | --- |
| `theme-<名前>` | テーマを選んでいるとき。名前の空白は `_` になります(たとえば `theme-My_theme`) |
| `project-<識別子>` | プロジェクトの画面 |
| `has-main-menu` | プロジェクトのメニューを表示する画面 |
| `controller-<名前>` | 常に(たとえば `controller-issues`) |
| `action-<名前>` | 常に(たとえば `action-show`) |
| `textarea-<フォント>` | ユーザーが個人設定でテキストエリアのフォント(`monospace` か `proportional`)を選んでいるとき |

`<body>` には、テキストの書式の設定を示す `data-text-formatting` もあります(Redmine 7 の既定は `common_mark`)。

`<html>` には、`lang`(ユーザーの言語)と `dir`(`ltr`、またはアラビア語、ペルシア語、ヘブライ語では `rtl`)があります。

<a id="page-structure"></a>

## 画面の構成

Redmine のレイアウト(`base.html.erb`)の主な要素です。

| 要素 | 内容 |
| --- | --- |
| `#wrapper` | すべて |
| `.flyout-menu` | 狭い画面のメニュー |
| `#top-menu` | トップメニューと `#account`(ログイン、個人設定) |
| `#header` | `#quick-search`、`#project-jump`、タイトル、`#main-menu`(プロジェクトのメニュー) |
| `#main` | `#sidebar` と `#content`。`#main` には `collapsiblesidebar` のクラスが付き、サイドバーのない画面では `nosidebar` が付きます |
| `#footer` | 「Powered by Redmine」 |
| `#ajax-indicator`<br>`#ajax-modal` | 読み込み中の表示とダイアログ |

<a id="right-to-left-languages"></a>

## 右から左に書く言語

アラビア語、ペルシア語、ヘブライ語では、`<html>` に `dir="rtl"` が付きます。Redmine のスタイルシートは、多くの場所で論理プロパティ(`margin-inline-start`、`inset-inline-end` など)を使い、レイアウトが文字の方向に従うようにしています。テーマでも論理プロパティを使い、ツールバーの言語の切り替えで確認してください。

<a id="narrow-screens"></a>

## 狭い画面

`responsive.css` は、幅が 900 ピクセルより狭いときのレイアウトを変えます。ヘッダーは固定のバーになり、トップメニュー、プロジェクトのメニュー、サイドバーは、ヘッダーのボタンで開くフライアウトメニュー(`.flyout-menu`)に移ります。`application.css` は、サイドバーの幅も画面の幅ごとに指定しています。

<a id="printing"></a>

## 印刷

`application.css` には、印刷用のスタイル(`@media print`)があります。トップメニュー、ヘッダー、プロジェクトのメニュー、サイドバー、フッター、`.contextual` のリンク、ほかの形式へのリンク、`hide-when-print` のクラスの要素は、印刷されません。

<a id="dark-mode"></a>

## ダークモード

Redmine のスタイルシートには、ダークモードのスタイル(`prefers-color-scheme`)はありません。ダークモードに対応するテーマは、自身で追加します。

<a id="emails"></a>

## メール

テーマはメールには適用されません。Redmine のメールのレイアウトは、`<style>` の要素に自身のスタイルを持っています。

<a id="restart-and-reload"></a>

## 再起動と再読み込み

- **新しいテーマ:** Redmine を再起動します。Redmine は、新しいテーマを再起動しなくても設定の画面に表示しますが、テーマのファイルの配信の登録は起動のときに行います。そのため、再起動するまで新しいテーマのファイルは見つかりません(HTTP 404。確認済み)。
- **ファイルの追加と削除:** Redmine を再起動します。Redmine は、テーマのスタイルシート、スクリプト、画像、ファビコンの一覧をメモリーに持っています。
- **ファイルの編集:** 画面を再読み込みします。開発モードでは、Redmine は変更したファイルを新しいダイジェストで配信します(確認済み)。
