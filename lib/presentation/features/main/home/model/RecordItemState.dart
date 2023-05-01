import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class RecordItemState {
  final String title;
  final List<Pair<String, String>> contents;
  final String imagePath;

  RecordItemState({
    required this.title,
    required this.contents,
    required this.imagePath,
  });
}
