import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'config_provider.g.dart';

@riverpod
Map<String, dynamic> globalConfigs(Ref ref) {
  return {
    "kApiDevUrl": Uri.http('localhost:5600', ''),
    "kApiProdUrl": Uri.http('localhost:3000', ''),
    "kApiVersion": 'v1',
  };
}
