import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/category.dart';

import '../../models/enums.dart';

@riverpod
final categoriesProvider = Provider<Map<CategoryEnum, Category>>((ref) {
  return {
    CategoryEnum.oficial: const Category(name: "Oficial", color: "green"),
    CategoryEnum.extraordinario:
        const Category(name: "Extraordinário", color: "red")
  };
});
