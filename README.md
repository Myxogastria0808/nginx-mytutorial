
# `nginx.conf`

```nginx.conf
events {
    # 1ワーカーの接続数
    worker_connections 1024;
    # 複数のリクエストを同時に受け付ける
    multi_accept on;
}

# HTTPモジュールの設定
http {
    # HTTP Response Headerの`Server`NginXのバージョン情報を非表示
    # 開発時以外は、非表示にするほうが良い
    server_tokens off;
    # server: バーチャルホストの設定
    server {
        # ポート番号
        listen 80;
        # ドメイン名 (HTTP Request Headerの`Host`に対応)
        server_name localhost;
        # HTTP Response Headerの`Content_Type`をUTF-8に設定
        charset UTF-8;
        include /etc/nginx/mime.types;

        # Gzip: データをzip圧縮して通信効率を上げる仕組み
        gzip on;
        gzip_min_length 1000;
        # `Content-Type`の設定 (text/html はデフォルトで圧縮されるので、`gzip_types`に`text/html`は書かない)
        gzip_types text/plain text/css application/json application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript;

        # ocation: URIのパスごとの設定
        location / {
            # ドキュメントルートを指定
            root /usr/share/nginx/html;
            # 該当パスにアクセスがあったときのインデックスとして使うファイルを指定
            index index.html;
        }
        # エラーページの設定
        error_page 404 /404.html;
        location = /404.html {
            root /usr/share/nginx/html;
            # 内部からのリクエストのためのみに使用される (外部からのリクエストを拒否)
            internal;
        }
        error_page 500 /500.html;
        location = /500.html {
            root /usr/share/nginx/html;
            internal;
        }
    }
}
```

## References

### `nginx.conf`

https://zenn.dev/kumao/scraps/5c388624940df0

https://qiita.com/Anorlondo448/items/c0234b2a5bf51578c974

https://qiita.com/RyoMa_0923/items/55078f6fb57e9d70a37f

https://dev.classmethod.jp/articles/nginx-tomcat-gzip/

https://qiita.com/morrr/items/7c97f0d2e46f7a8ec967

### ghcr trouble shooting

https://github.com/orgs/community/discussions/25768