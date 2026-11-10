# Redmine Design Guide

Redmine 7 の画面がどう作られているかを、本体と同じ見た目と動きのプラグインの画面を作る人のためにまとめます。あわせて、テーマの作者のために、Redmine 7 がテーマを適用する仕組みをまとめます。パターンは Redmine 7.0.3 から取りました。それぞれに、使っている本体のビュー、写すマークアップとヘルパー、Redmine の標準のスタイルシート(`app/assets/stylesheets/application.css`)がそのクラスに当てるスタイルを書きます。

<a id="screens"></a>

## 画面

方針: 画面を書く前に、同じ種類の本体の画面を選び、そのビューに倣って書きます。マークアップ、ヘルパー、クラスが同じなら、Redmine の標準のスタイルシートが画面を整え、テーマも本体の画面と同じように画面を整えます。クラスや CSS を足すのは、本体にパターンがないところだけです。

| 画面の種類 | 倣う本体の画面 | ページ |
| --- | --- | --- |
| 画面のタイトル、右上のアクション、セクション | 管理 › ユーザー、ロールの編集 | [画面の組み立て](page.md) |
| アクションのあるレコードの一覧 | 管理 › 選択肢の値 | [一覧](lists.md) |
| 値と確認の結果の表示 | 管理 › 情報 | [情報の表示](information.md) |
| タブに分かれた設定 | 管理 › 設定 | [設定](settings.md) |
| レコードを作る・編集するフォーム | 新しいチケット、トラッカーの編集 | [フォーム](forms.md) |
| 通知、エラー、警告、データがないとき | 設定の保存、エラーのあるフォーム、空の一覧 | [メッセージ](messages.md) |
| アイコン、アクションのリンク、削除のリンク | 画面全体 | [アイコンとリンク](icons-and-links.md) |
| プロジェクトの設定のタブ | プロジェクト › 設定 | [プロジェクトの設定](project-settings.md) |
| 画面を操作しながら読む、画面の横のパネル | 本体になし (Redmine Help のヘルプのパネル) | [サイドパネル](side-panel.md) |

合う本体の画面がないときは、[パターンにない画面を作るとき](no-pattern.md)を参照してください。色は本体の変数を使います。[カラーパレット](colors.md)を参照してください。

<a id="themes"></a>

## テーマ

- [Redmine 7 のテーマ](themes.md): Redmine 7 がテーマを見つけ、読み込み、適用する仕組みと、テーマで変えられるもの
- [テーマのチェックリスト](theme-checklist.md): テーマが対応する必要のある項目と、それぞれを確認する [Redmine Lookbook](https://redmine-kit.github.io/redmine_lookbook/ja/) のプレビュー

<a id="screenshots"></a>

## スクリーンショット

スクリーンショットは、リリースのとおりの Redmine 7.0.3 に Redmine のテストデータを入れ、幅 1280 px(本文の部分)で、英語と日本語で撮ったものです。`bin/screenshots` で、Docker の中で撮り直せます(Redmine 7.0.3、PostgreSQL 16、ヘッドレスの Chromium。撮る画面は `test/screens.rb`)。

```sh
bin/screenshots
```

テーマのチェックリストの 2 枚の画像(コンテキストメニュー、Git のリビジョン)は、Redmine Lookbook のプレビューを撮ったものです。サイドパネルの画像は、本体にサイドパネルがないため、Redmine Help の画面 (Redmine Help の `bin/screenshots`) です。

Redmine は Jean-Philippe Lang の商標です。このガイドは、パターンを示すために Redmine のコード(GPL-2.0)を引用しています。

<a id="sponsors"></a>

## スポンサー

<Sponsors ids="keyselect"><a href="https://www.keyselect.co.jp/">KEY SELECT</a></Sponsors>

<a id="license"></a>

## ライセンス

Redmine Design Guide は、GNU General Public License バージョン 2 またはそれ以降のバージョンで公開しています。[LICENSE](../../LICENSE) を参照してください。Redmine の非公式のプロジェクトです。
