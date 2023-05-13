localization:
	flutter pub run easy_localization:generate -S assets/localization
	flutter pub run easy_localization:generate -f keys -S assets/localization -o locale_keys.g.dart

get:
	flutter pub get

clean:
	flutter clean
	make get

build_android_apk:
	clear
	make clean
	make build
	flutter build apk --target-platform android-arm,android-arm64 --split-per-abi
	open build/app/outputs/flutter-apk

build_android_aab:
	clear
	make clean
	make build
	flutter build appbundle && open build/app/outputs/bundle/release

build_ios:
	clear
	make clean
	make build
	flutter build ipa && open ./build/ios/archive/Runner.xcarchive

buildm:
	flutter pub run build_runner build --delete-conflicting-outputs
	
build_watch:
	flutter pub run build_runner watch --delete-conflicting-outputs