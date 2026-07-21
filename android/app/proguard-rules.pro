# Google Play Core & Deferred Components
-keep class com.google.android.play.core.** { *; }
-keep interface com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# AndroidX & Flutter Engine dynamic features
-keep class io.flutter.embedding.engine.deferred.** { *; }
-keep class io.flutter.plugin.editing.** { *; }

# Prevent R8 from breaking GSON / Serialized Hive models if using Json
-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod