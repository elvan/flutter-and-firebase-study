import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreRepository {
  static final instance = FirestoreRepository._();

  FirestoreRepository._();

  Future<void> setData({
    String path,
    Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((querySnapshot) {
      return querySnapshot.docs.map((documentSnapshot) {
        return builder(documentSnapshot.data());
      }).toList();
    });
  }
}
