# 調査用: Helix Coreサーバの構築用Dockerfile

各ディレクトリには、以下の設定値で起動するHelix CoreのDockerfileを格納しています。

| GitHub<br />ディレクトリ | DockerHub<br />タグ名 | 大文字小文字 | SSL  | Unicode | サンプルディポ |
| ------------------------ | --------------------- | ------------ | ---- | ------- | -------------- |
| plain_c0                 | 同左                  | 区別する     | 無効 | 有効    | なし           |
| plain_c1                 | 同左                  | 区別しない   | 無効 | 有効    | なし           |
| plainssl_c0              | 同左                  | 区別する     | 有効 | 有効    | なし           |
| plainssl_c1              | 同左                  | 区別しない   | 有効 | 有効    | なし           |
| sampledepot_c0           | 同左                  | 区別する     | 無効 | 有効    | あり           |
| sampledepot_c1           | 同左                  | 区別しない   | 無効 | 有効    | あり           |
| sampledepotssl_c0        | 同左                  | 区別する     | 有効 | 有効    | あり           |
| sampledepotssl_c1        | 同左                  | 区別しない   | 有効 | 有効    | あり           |
| plain_package_installer  | pkg_c0                | 区別する     | 無効 | 有効    | なし           |
| plain_package_installer  | pkg_c1                | 区別しない   | 無効 | 有効    | なし           |
| plain_package_installer  | pkg_ssl_c0            | 区別する     | 有効 | 有効    | なし           |
| plain_package_installer  | pkg_ssl_c1            | 区別しない   | 有効 | 有効    | なし           |

- ディレクトリ名の `c0` は、`大文字小文字の区別あり`を表します。

- ディレクトリ名の `c1` は、`大文字小文字の区別なし`を表します。

- ディレクトリ名の `ssl` は、`SSL有効`を表します。

- DockerHubからビルド済みイメージを取得する際は、
  DockerHubタグ名を使用して以下のコマンドを実行します。

  ```
  docker pull p4misc/p4d:DockerHubタグ名
  ```

  

## コンテナの配備方法(plain_package_installer以外)

以下のコマンドでコンテナを起動します。
```
docker build -t p4d .
docker run -p 1666:1666 -itd p4d
```

docker-composeでもコンテナを起動できます。
```
docker-compose up -d
```



## コンテナの配備方法(plain_package_installer)

DockerのARG命令を使用して作成するHelix Coreサーバの設定を調整できるようにしています。

また、`docker-compose` の実行時に設定ファイルを環境変数ファイル `.env` から読み込むようにしています。

`.env` に以下の設定を施してから `docker-compose` を実行してください。

| 設定項目        | 設定値の例 | 説明                                                         |
| --------------- | ---------- | ------------------------------------------------------------ |
| TCP_PORT        | 1666       | Helix Coreの待ち受けポート番号                               |
| P4_SUPER_USER   | super      | Helix Coreのsuper権限をもつユーザのアカウント名              |
| P4_SUPER_PASSWD | (省略)     | P4_SUPER_USERで設定したユーザのパスワード                    |
| P4_SERVER_ID    | commit     | Helix Coreサーバの識別子                                     |
| P4_UNICODE      | --unicode  | Unicodeモードを有効にする場合は --unicode を設定<br />Unicodeモードを有効にしない場合は値を空に設定 |
| P4_CASE         | 0 または 1 | 大文字小文字を区別する場合は 0 を設定<br />大文字小文字を区別する場合は 1 を設定 |
| P4_SSL          | ssl        | SSLを有効にする場合は ssl を設定<br />SSLを有効にしない場合は値を空に設定 |

docker-composeを実行

```
docker-compose up -d
```



## Helix Coreサーバの利用方法

- 接続先の指定方法について

  - SSL=無効の場合は、`IPアドレス`:1666 または `ホスト`:1666 を接続先にしてアクセスします。

  ```
  例: p4 -p 192.168.1.100:1666 info
  ```

  - SSL=有効の場合は、ssl:`IPアドレス`:1666 または ssl:`ホスト`:1666 を接続先にしてアクセスします。
    また、GUIクライアント以外からアクセスする場合は、p4 trustを実行して接続先の信頼性を確保してから以降のコマンドを実行します。

  ```
  例: p4 -p ssl:192.168.1.100:1666 trust
  ```

- 登録アカウントについて

  - サンプルディポ=なしの場合は、Helix Coreに何もデータが登録されていません。
    このため、ユーザも新規に登録してから使用する必要があります。
  - サンプルディポ=ありの場合は、ユーザ `bruno` を使用することができます。
    ユーザ `bruno` は管理者権限をもつユーザです。


