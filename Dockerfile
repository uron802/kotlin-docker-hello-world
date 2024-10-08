# Kotlinのベースイメージを取得
FROM gradle:jdk11 AS build

# 作業ディレクトリを設定
WORKDIR /app

# プロジェクトファイルをコピー（存在する場合）
COPY . .

# プロジェクトが存在しない場合はGradleで初期化
RUN if [ ! -f "build.gradle.kts" ]; then gradle init --type kotlin-application; fi

# プロジェクトをビルド
RUN gradle build

# 実行用の軽量イメージを使う
FROM openjdk:11-jre-slim

WORKDIR /app

# ビルドされたjarファイルをコピー
COPY --from=build /app/build/libs/kotlin-docker-hello-world.jar /app/kotlin-docker-hello-world.jar

# Kotlinアプリケーションを実行
ENTRYPOINT ["java", "-jar", "kotlin-docker-hello-world.jar"]
