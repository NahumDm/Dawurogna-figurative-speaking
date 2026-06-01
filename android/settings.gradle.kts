// Optional per-developer overrides (android/gradle-local.properties, gitignored).
file("gradle-local.properties").takeIf { it.exists() }?.let { localFile ->
    val local = java.util.Properties()
    localFile.inputStream().use { local.load(it) }
    local.getProperty("org.gradle.java.home")?.let { jdkHome ->
        System.setProperty("org.gradle.java.home", jdkHome)
    }
}

pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    // Pins Kotlin for Flutter plugins that still apply KGP (app uses built-in Kotlin).
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")
