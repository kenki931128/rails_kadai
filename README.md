# 情報システム論実習 Ruby on rails format

情報システム論実習で使用するRuby on railsが使える環境を提供します．

Macユーザを前提に作っていますので，それ以外の方はTAに尋ねてください．

## 準備

- [Xcode](https://itunes.apple.com/jp/app/xcode/id497799835?mt=12)とcommand line toolsが必要です． 

未インストールの場合，上記リンクからApp storeへ行きXcodeをインストールしてください．

そのアプリを起動後，コマンドラインで
 
`xcode-select --install`

を実行してください．

## 環境設定方法

以下のコマンドを順番に実行してください．(任意のディレクトリ下で)

1. `git clone https://github.com/kenki931128/rails_kadai.git`
2. `cd rails_kadai`
3. `rm -rf .git/`
4. `./setup` (VirtualBoxとVagrantがインストール済みなら不要)

## Ruby on railsの準備

1. `vagrant up` (初めてだと25分くらいかかる．以降は1分半程度)
2. `vagrant ssh` (ローカルサーバにログイン)
3. `cd /vagrant`
4. `rails new (アプリ名)`
5. `cd (アプリ名)`
6. `rails s`

でhttp://192.168.33.10:3000/ にアクセスできるかどうかテスト。

## 以降の流れ

- rails_kadaiの下に(アプリ名)のフォルダがあるはず．
- これを直接編集すればいい

見た目を確認したい時はvagrantサーバにログイン後

1. `cd /vagrant/(アプリ名)`
2. `rails s`

でhttp://192.168.33.10:3000/ にアクセス

## vagrant のコマンドについて

vagrantとは仮想環境を手軽に構築するためのコマンドラインツール群です。

|説明|コマンド|
|:--:|:--:|
|仮想マシンの起動（プロジェクトのディレクトリに移動してから）|`vagrant up`|
|仮想マシンの停止|`vagrant halt`|
|仮想マシンの状態の確認|`vagrnt status`|
|仮想マシンへのシェルログイン|`vagrant ssh`|
|仮想マシンの削除|`vagrant remove <box_name>`|

## Herokuへのアップロード方法

### デプロイ用のファイル修正
1. `Gemfile`を下記のように修正

```
gem 'sqlite3', group: :development
gem 'pg', group: :production
```

2. `bundle install`

3. `config/database.yml`の`production`の項目を下記のように修正
```
production:
  <<: *default
  adapter: postgresql
  encoding: unicode
  pool: 5
```

4. `bin`以下の全てのファイルの先頭行を`#!/usr/bin/env ruby2.4`から`#!/usr/bin/env ruby`にする

#### herokuへのデプロイとgit
[git](https://github.com/)と[heroku](https://jp.heroku.com/home)のアカウントを持っていない人は新しく作る。

1. `heroku login`
2. `heroku create (サーバー名)`でサーバーを作る（被るとダメなので適当に長い文字列で）
3. `git init`
4. `git add .`
5. `git commit -m "initial commit"`
6. `heroku git:remote -a (サーバー名)`
7. `git push heroku master`
8. `heroku run:detached rake db:migrate` (Herokuで動くようになる)

http://(サーバー名).herokuapp.com/ にアクセスしてhogeが表示されているか確認。

