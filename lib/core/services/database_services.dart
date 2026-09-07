
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DatabaseServices {
  Future<String> addData({
    required String path,
    required Map<String, dynamic> data,
    String? uId,
  });

  Future<dynamic> getData({
    required String path,
    String? uId,
    Map<String, dynamic>? query,
  });

  Stream<dynamic> getStreamData({
    required String path,
    String? uId,
    Map<String, dynamic>? query,
  });

  Future<void> deleteData({required String path, required String uId});

  Future<bool> checkExists({required String path, required String uId});

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String docId,
  });

  Future<void> deleteCollection(String collectionName);
  Future<bool> areAllCartsEmpty();

}

class FirestoreDatabase implements DatabaseServices {
  @override
  Future<String> addData({
    required String path,
    required Map<String, dynamic> data,
    String? uId,
  }) async {
    try {
      if (uId != null) {
        await FirebaseFirestore.instance.collection(path).doc(uId).set(data);
        return uId;
      } else {
       final docRef = await FirebaseFirestore.instance.collection(path).add(data);
        data['id'] = docRef.id;
        await docRef.update(data);
        return docRef.id;
      }
    } on Exception catch (e) {
      throw (e.toString());
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? uId,
    Map<String, dynamic>? query,
  }) async {
    try {
      if (uId != null) {
        final user = await FirebaseFirestore.instance
            .collection(path)
            .doc(uId)
            .get();
        print('print user id is when uid!=null is  ${user.id}');
        if (!user.exists || user.data() == null) {
          throw Exception('المستخدم ليس موجود في قاعده البيانات');
        }
        return user.data() as Map<String, dynamic>;
      } else {
        Query<Map<String, dynamic>> data = FirebaseFirestore.instance
            .collection(path);

        if (query != null) {
          final limit = query['limit'];
          final orderBy = query['orderBy'];
          final descending = query['descending'];
          final startAt = query['startAt'];
          final endAt = query['endAt'];
          final where = query['where'];
          final isEqualTo = query['isEqualTo'];

          if (where != null) {
            data = data.where(where, isEqualTo: isEqualTo);
          }
          if (orderBy != null) {
            data = data.orderBy(orderBy, descending: descending);
          }
          if (limit != null) {
            data = data.limit(limit);
          }
          if (startAt != null) {
            data = data.startAt([startAt]);
          }
          if (endAt != null) {
            data = data.endAt([endAt]);
          }
        }

        var result = await data.get();
        return result.docs.map((user) {
          return {'id': user.id, ...user.data()};
        }).toList();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> checkExists({required String path, required String uId}) async {
    final doc = await FirebaseFirestore.instance
        .collection(path)
        .doc(uId)
        .get();

    return doc.exists;
  }

  @override
  Future<void> deleteData({required String path, required String uId}) async {
    await FirebaseFirestore.instance.collection(path).doc(uId).delete();
  }

  @override
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
    required String docId,
  }) async {
    final userRef = FirebaseFirestore.instance.collection(path).doc(docId);
    await userRef.update(data);
  }

  @override
  Stream<dynamic> getStreamData(
      {required String path, String? uId, Map<String, dynamic>? query}) async*
  {
    try {
      if (uId != null) {
        final user = await FirebaseFirestore.instance
            .collection(path)
            .doc(uId)
            .get();
        if (!user.exists || user.data() == null) {
          throw Exception('المستخدم ليس موجود في قاعده البيانات');
        }
        yield user.data() as Map<String, dynamic>;
      } else {
        Query<Map<String, dynamic>> data = FirebaseFirestore.instance
            .collection(path);

        if (query != null) {
          final limit = query['limit'];
          final orderBy = query['orderBy'];
          final descending = query['descending'];
          final startAt = query['startAt'];
          final endAt = query['endAt'];
          final where = query['where'];
          final isEqualTo = query['isEqualTo'];

          if (where != null) {
            data = data.where(where, isEqualTo: isEqualTo);
          }
          if (orderBy != null) {
            data = data.orderBy(orderBy, descending: descending);
          }
          if (limit != null) {
            data = data.limit(limit);
          }
          if (startAt != null) {
            data = data.startAt([startAt]);
          }
          if (endAt != null) {
            data = data.endAt([endAt]);
          }
        }
        await for (var snapshot in data.snapshots()) {
          yield snapshot.docs.map((e) {
            return {'id': e.id, ...e.data()};
          }).toList();
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteCollection(String collectionName) async {
    final snapshot = await FirebaseFirestore.instance.collection(collectionName).get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  @override
  Future<bool> areAllCartsEmpty() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('carts')
        .get();

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final cartItems = data['cartItems'];

      if (cartItems is List && cartItems.isNotEmpty) {
        return false;
      }
    }

    return true;
  }
}
