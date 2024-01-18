import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:skinsavvy/core/config.dart';

class AuthService {
  Future<Response> signInWithGoogle() async {    
    // begin interactive sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn(
      clientId: AppConfig.googleClientId,
    ).signIn();

    // Check if the user canceled the login process
    if (gUser == null) {
      throw Exception('Login canceled by user');
    }

    // get auth details
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    if (gAuth.accessToken == null || gAuth.idToken == null) {
      throw Exception('Failed to get auth details');
    }

    // sign in using token
    Response response = await post(
      Uri.parse('${AppConfig.serverAddress}/sessions/oauth/google'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id_token': gAuth.idToken,
        'access_token': gAuth.accessToken,
      }),
    );

    return response;
  }
}
