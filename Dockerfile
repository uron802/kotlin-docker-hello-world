# Kotlinのベースイメージを取得
FROM gradle:jdk11 AS base

# 作業ディレクトリを設定
WORKDIR /app

# プロジェクトファイルをコピー
COPY . .

# Kotlinアプリケーションを実行する代わりにbashを起動
ENTRYPOINT ["/bin/bash"]
