# Flutter Build Simple CMD 명령어 							\
												 			\
	make splash-rebuild -> 스플래시 옵션 변경 후 재설정. 			\
	make rebuild: 개발 버전 빌드								\
	make rebuild-release: 배포 버전 빌드						\



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