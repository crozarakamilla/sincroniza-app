import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/enums.dart';

@riverpod
final categoriesProvider = Provider<Map<Category, String>>((ref) {
  return {
    Category.oficial: "Oficial",
    Category.extraordinario: "Extraordinário"
  };
});
