# Flutter Build Simple CMD 명령어 							\
												 			\
	make run-splash -> 스플래시 옵션 변경 후 재설정. 			\
	make run: 개발 버전 빌드								\
	make run-release: 배포 버전 빌드						\



# 스플래시 화면 재 설정
run-splash:
	flutter pub run flutter_native_splash:remove
	flutter pub run flutter_native_splash:create

# DebugDev Rebuild
run-dev:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter run --debug --flavor dev -t lib/env/dev.dart
	#(flutter run --flavor dev) || flutter run

# ProdRelease Rebuild
run-prod:
	flutter clean
	flutter pub get
	cd ios && pod install
	flutter run --release --flavor prod -t lib/env/prod.dart

# android apk-release create
create-apk-prod:
	flutter build apk --release --flavor prod --no-tree-shake-icons -t lib/env/prod.dart

# android apk-debug create
create-apk-dev:
	flutter build apk --debug --flavor dev --no-tree-shake-icons -t lib/env/dev.dart

# android aab-prod create
create-aab-prod:
	flutter build appbundle --release --flavor prod --no-tree-shake-icons -t lib/env/prod.dart


