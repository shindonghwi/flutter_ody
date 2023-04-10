import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/features/login/notifier/LoginLoadingNotifier.dart';

final loginLoadingProvider = StateNotifierProvider<LoginLoadingNotifier, bool>(
  (_) => LoginLoadingNotifier(),
);
