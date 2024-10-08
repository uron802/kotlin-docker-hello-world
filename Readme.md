
# First Kotlin Docker Application - Local Development Environment

このプロジェクトでは、Docker Composeを使用してKotlinアプリケーションのローカル開発環境を構築し、手動でビルド・実行する手順を説明します。

## 前提条件

以下のツールがインストールされていることを確認してください:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## プロジェクトの構成

このプロジェクトには以下の主なファイルが含まれています:

```
kotlin-docker-hello-world/
├── build.gradle.kts            # Gradleビルド設定ファイル
├── Dockerfile                  # Docker設定ファイル
├── docker-compose.yml          # Docker Compose設定ファイル
├── settings.gradle.kts         # Gradleの設定ファイル
└── src/                        # Kotlinのソースコードが入るディレクトリ
    └── main/kotlin/
        └── App.kt              # Kotlinコード (Hello, World!)
```

## 環境構築手順

### 1. Dockerイメージのビルド

まず、コンテナをビルドして立ち上げます。この手順では、`docker-compose build` はアプリケーションのビルドは行いません。

```bash
docker-compose up -d
```

これにより、バックグラウンドでコンテナが起動します。

### 2. コンテナ内に入る

次に、起動したコンテナ内に `bash` で入ります。

```bash
docker-compose exec kotlin-app bash
```

このコマンドにより、コンテナ内で操作ができるようになります。

### 3. 手動でビルドを実行

コンテナ内に入ったら、Gradleを使ってプロジェクトをビルドします。

```bash
gradle build
```

ビルドが成功すると、JARファイルが `/app/build/libs/` に生成されます。ローカル環境の `build/libs/` ディレクトリに自動的に同期されます。

### 4. アプリケーションを実行

ビルドが完了したら、次のコマンドでアプリケーションを手動で実行します。

```bash
java -jar /app/build/libs/kotlin-docker-hello-world.jar
```

これにより、Kotlinアプリケーションが実行され、`Hello, World!` が出力されます。

## ファイルの変更と再ビルド

`src/` ディレクトリや `build.gradle.kts` に変更を加えると、それがコンテナ内にも同期されます。その後、再度コンテナ内で手動でビルドを実行し、アプリケーションを再実行することができます。

### 1. ソースコードの変更
`src/main/kotlin/App.kt` のコードを変更します。

```kotlin
fun main() {
    println("Hello, Docker!")
}
```

### 2. 再ビルドと再実行

変更を反映させるために、再度以下の手順を実行します。

```bash
# コンテナ内での再ビルド
gradle build

# 再実行
java -jar /app/build/libs/kotlin-docker-hello-world.jar
```

これで、新しい内容が出力されます。

## クリーンアップ

開発が終わったら、コンテナを停止・削除します。

```bash
docker-compose down
```

このコマンドで、起動していたコンテナを停止し、関連リソースがクリーンアップされます。

## 注意事項

- ビルド時の成果物（JARファイルなど）は、ローカルの `build/libs/` フォルダに自動的に同期されます。
- すべてのビルドは手動で行われるため、アプリケーションの実行前に必ず手動ビルドを実行してください。
