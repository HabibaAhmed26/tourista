import 'package:tourista/core/network/firestore/doc_constants.dart';

class AppUser {
  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePictureUrl;

  AppUser({
    required this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profilePictureUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      DocConstants.firstName: firstName,
      DocConstants.lastName: lastName,
      DocConstants.email: email,
      DocConstants.profilePictureUrl: profilePictureUrl,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map[DocConstants.uid],
      email: map[DocConstants.email],
      firstName: map[DocConstants.firstName],
      lastName: map[DocConstants.lastName],
      profilePictureUrl: map[DocConstants.profilePictureUrl],
    );
  }
}
