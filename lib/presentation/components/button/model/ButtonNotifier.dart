import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';

class ButtonNotifier extends StateNotifier<ButtonState> {
  final ButtonState state;

  ButtonNotifier({required this.state}) : super(state);

  void changeState(ButtonState buttonState) {
    state = buttonState;
  }
}
