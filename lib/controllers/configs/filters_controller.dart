import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sincroniza/models/enums.dart';

final filtersControllerProvider = StateProvider<Map<String, Object>>(
  // We return the default sort type, here name.
  (ref) => {
    FilterType.byUserId.name: '',
    FilterType.startDate.name: '',
    FilterType.endDate.name: '',
    FilterType.category.name: ''
  },
);
