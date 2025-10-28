import 'package:tourista/core/network/firestore/doc_constants.dart';

class AppUser {
  final String? uid;
  final String email;
  final String firstName;
  final String lastName;
  final String? profilePictureUrl;

  AppUser({
    this.uid,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profilePictureUrl,
  });
  AppUser copyWith({
    String? uid,
    String? email,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

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
