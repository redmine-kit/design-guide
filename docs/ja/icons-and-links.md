# アイコンとリンク

アイコンは 1 つの SVG のスプライトから取り、アクションはアイコン付きのリンクにします。本体と同じヘルパーを使えば、テーマがアイコンを差し替え、リンクを整えられます。

<a id="icons"></a>

## アイコン

`sprite_icon(name, label = nil, …)` は、スプライト(`app/assets/images/icons.svg`。7.0.3 では 118 個のアイコン。出典は `config/icon_source.yml`)の記号を使うインラインの SVG を書きます。

```html
<svg class="s18 icon-svg"><use href="/assets/icons-….svg#icon--add"></use></svg><span class="icon-label">New value</span>
```

| 項目 | 内容 |
| --- | --- |
| 大きさ | デフォルトは 18px です(`size:`)。クラスは `s<大きさ>` です |
| 塗りつぶし | `style: :filled` で `icon-svg-filled` が付きます |
| 右から左の言語 | `rtl: true` で、右から左の言語では矢印を左右反転します |
| アイコンだけ | `icon_only: true` で、ラベルに `hidden` のクラスが付きます。リンクには、`reorder_handle` や `toggle_checkboxes_link` と同じく、`icon-only` のクラスと `title` を付けます |
| テーマのアイコン | 今のテーマのスプライトにそのアイコンがあれば、`sprite_icon` はテーマのスプライトを使います([Redmine 7 のテーマ](themes.md)) |
| プラグインのアイコン | `sprite_icon('name', plugin: :my_plugin)` は、プラグインのアセットのスプライト `icons.svg`(`plugin_assets/my_plugin/icons.svg`)を使います。合うものがあれば、本体のアイコンを使います |

`.icon` と `.icon-only` は、アイコンとラベルを横に並べます。リンクでは、マウスを乗せるとアイコンの色が変わります。

<a id="action-links"></a>

## アクションのリンク

アクションは、アイコンと `icon icon-<name>` のクラスのあるリンクです。画面の右上の `.contextual` か、一覧の上の `<p>` に置きます([一覧](lists.md))。`app/views/enumerations/index.html.erb` から引用します。

```erb
<p><%= link_to sprite_icon('add', l(:label_enumeration_new)), new_enumeration_path(:type => klass.name), :class => 'icon icon-add' %></p>
```

| アクション | アイコン | クラス | ラベル |
| --- | --- | --- | --- |
| 追加 | `add` | `icon icon-add` | `label_<もの>_new` |
| 編集 | `edit` | `icon icon-edit` | `button_edit` |
| コピー | `copy` | `icon icon-copy` | `button_copy` |
| 削除 | `del`(`delete_link` で) | `icon icon-del` | `button_delete` |
| 接続の確認 | `arrow-right` | `icon icon-test` | `button_test` |

- データを変えるアクションは `:method => :post`(か `:delete`)にします。`link_to l(:label_send_test_email), test_email_path, :method => :post` と同じです。
- スクリプトを動かすリンクは `link_to_function` を使います。

<a id="delete-links"></a>

## 削除のリンク

`delete_link(url)` は、確認(`text_are_you_sure`)と `:method => :delete` の付いた削除のアクションを書きます。

```erb
<%= delete_link enumeration_path(enumeration) %>
```

`remove_link(url)` は、レコードのあいだのつながりを外すための、同じ形のリンクです(`icon-link-break`、`button_remove`)。

<a id="actions-in-a-row"></a>

## 行のアクション

一覧の行のアクションは `td.buttons` に入れます(終わりの側に寄せ、折り返さず、リンクのあいだは `0.6em`)。本体では、並べ替えのハンドル(`reorder_handle`)を最初に、削除を最後に置き、ほかのアクションをそのあいだに置きます(カスタムフィールドでは、並べ替え、コピー、削除)([一覧](lists.md#columns))。

<a id="checking-many-checkboxes"></a>

## チェックボックスをまとめて付ける・外す

- `check_all_links('form_id')`: フォームや要素のすべてのチェックボックスに対する「すべてにチェックをつける | すべてのチェックを外す」のリンクです(設定 › メール通知)。
- `toggle_checkboxes_link(selector)`: チェックボックスを切り替えるチェックのアイコンです。`legend` か見出しのセルに置きます(トラッカーの編集、ロールの編集の権限)。

<a id="yes-and-no"></a>

## はい・いいえ

`checked_image(value)` は、真のときにチェックのアイコン(`span.icon-only.icon-checked`)を出し、偽のときは何も出しません。`td.tick` に入れます。失敗することのある確認には、管理 › 情報と同じく `icon-ok`(緑)と `icon-error`(赤)を使います([情報の表示](information.md))。
