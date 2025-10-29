import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/network/firestore/doc_constants.dart';

class FireStore {
  final FirebaseFirestore _firestore;
  FireStore({required FirebaseFirestore firestore}) : _firestore = firestore;
  CollectionReference<Map<String, dynamic>> get _users =>
      _firestore.collection(DocConstants.usersCollection);
  Future<void> createUserProfile(AppUser user) async {
    await _users.doc(user.uid).set(user.toMap());
  }

  Future<void> deleteUser(String uid) async {
    await _users.doc(uid).delete();
  }

  Future<AppUser?> getUserProfile(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.data()!);
  }

  Future<void> updateUserProfile(AppUser user) async {
    await _users.doc(user.uid).update(user.toMap());
  }
}
