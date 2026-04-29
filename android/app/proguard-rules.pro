# Fix path_provider crash (PathUtils issue)
-keep class io.flutter.util.** { *; }

# Fix cached_network_image & cache manager
-keep class com.bumptech.glide.** { *; }
-keep class okhttp3.** { *; }
-keep class okio.** { *; }

# Avoid warnings
-dontwarn okhttp3.**