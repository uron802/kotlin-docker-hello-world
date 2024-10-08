plugins {
    kotlin("jvm") version "1.8.0"
    application
}

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
}

application {
    mainClass.set("AppKt")  // メインクラスを指定
}

tasks.jar {
    manifest {
        attributes(
            "Main-Class" to "AppKt"  // JARファイルにメインクラスを指定
        )
    }
    archiveFileName.set("kotlin-docker-hello-world.jar")
}
