import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tourista/core/models/user_model.dart';
import 'package:tourista/core/network/firestore/firestore.dart';

class ImgHosting {
  final FireStore _firestore;
  ImgHosting({required FireStore firestore}) : _firestore = firestore;

  Future<String?> uploadToImgBB(File imageFile) async {
    try {
      String apiKey =
          'dd104cc73ebe87992500aebac8ef4cbe'; // Get free API key from imgbb.com

      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      var response = await http.post(
        Uri.parse('https://api.imgbb.com/1/upload'),
        body: {'key': apiKey, 'image': base64Image},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['data']['url'];
      }
      return null;
    } catch (e) {
      print('Error uploading to ImgBB: $e');
      return null;
    }
  }

  // Save URL to Firestore
  Future<void> saveProfilePictureUrl(String imageUrl, AppUser user) async {
    try {
      user = user.copyWith(profilePictureUrl: imageUrl);
      _firestore.updateUserProfile(user);
    } catch (e) {
      print('Error saving profile picture URL: $e');
    }
  }
}
