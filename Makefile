# 스플래시 화면 재 설정
splash-rebuild:
	flutter pub run flutter_native_splash:remove
	flutter pub run flutter_native_splash:create

# Debug Rebuild
rebuild:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter run

# Release Rebuild
rebuild-release:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter run --release --no-sound-null-safety