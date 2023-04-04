import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';

class OutlineButtonNotifier extends StateNotifier<ButtonState> {
  final ButtonState state;

  OutlineButtonNotifier({required this.state}) : super(state);

  void changeState(ButtonState buttonState) {
    state = buttonState;
  }
}
