import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/utils/ai_utils.dart';

part 'ai_utils_repository.g.dart';

@riverpod
AiUtilsRepository aiUtilsRepository(Ref ref) {
  return AiUtilsRepository();
}

class AiUtilsRepository {
  AiUtilsRepository();

  Future<List<Map<String, dynamic>>> processText(
      String unstructuredText) async {
    List<Map<String, dynamic>> text =
        await structureTextWithAI(unstructuredText);
    return text;
  }
}
