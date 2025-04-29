import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/models/category.dart';

import '../../models/enums.dart';

final categoriesProvider = Provider<Map<String, Category>>((ref) {
  return {
    CategoryEnum.oficial.name:
        const Category(name: "Oficial", color: Colors.blueAccent),
    CategoryEnum.extraordinario.name:
        const Category(name: "Extraordinário", color: Colors.red),
    CategoryEnum.didatico.name:
        const Category(name: "Didático", color: Colors.green),
  };
});
