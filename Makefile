# Flutter Build Simple CMD 명령어 							\
												 			\
	make run-splash -> 스플래시 옵션 변경 후 재설정. 			\
	make run: 개발 버전 빌드								\
	make run-release: 배포 버전 빌드						\



# 스플래시 화면 재 설정
run-splash:
	flutter pub run flutter_native_splash:remove
	flutter pub run flutter_native_splash:create

# Debug Rebuild
run:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter run --flavor dev

# Release Rebuild
run-release:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter run --release --no-sound-null-safety --flavor prod
