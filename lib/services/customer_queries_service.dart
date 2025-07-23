import 'package:flutter/material.dart' show immutable;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/extensions.dart';
import '../config/strings.dart';
import '../models/query_model.dart';
import '../providers/auth_provider.dart';

@immutable
class CustomerQueriesService {
  final String? uid;
  const CustomerQueriesService(this.uid);

  // 🔹 Logout
  Stream<List<QueryModel>> getAllQueries() {
    try {
      return uid != null
          ? Collections.queries
              .orderBy(Fields.createdAt, descending: true)
              .limit(10)
              .snapshots()
              .map((docs) =>
                  docs.docs.map((e) => QueryModel.fromSnapshot(e)).toList())
          : Stream.empty();
    } catch (e) {
      throw e.firebaseErrorMessage;
    }
  }
}

final customerQueriesServiceProvider = Provider<CustomerQueriesService>((ref) {
  final uid = ref.watch(authUidProvider);
  return CustomerQueriesService(uid);
});
