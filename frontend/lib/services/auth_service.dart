import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    // begin interactive sign-in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // Check if the user canceled the login process
    if (gUser == null) {
      return null; // Return null or handle cancellation appropriately
    }

    // get auth details
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // create new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // sign in with credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
