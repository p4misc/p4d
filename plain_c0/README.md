# Helix Coreサーバの構築用Dockerfile

## コンテナの配備方法
以下のコマンドでHelix Coreサーバを配備したコンテナを起動します。
```
docker build -t p4d .
docker run -p 1666:1666 -itd p4d
```

docker-composeでもコンテナを起動できます。
```
docker-compose up -d
```

## Helix Coreサーバの設定
```
- unicode有効
- ファイルの大文字小文字を区別しない
- SSL無効
- 1666ポートで稼働
- 事前登録ユーザなし
```

## Helix Coreサーバへのアクセス方法
P4Vを起動して、`IPアドレス`:1666ポートで待ち受けしているDockerコンテナ内のHelix Coreにアクセスします。

ユーザが全く登録されていない状態で稼働しているので、最初にユーザを追加する必要があります。
