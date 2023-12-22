import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential> googleSignIn() async {
    UserCredential userCredential;
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    if (googleSignInAccount == null) {
      print('google sign error');
      // return "Google Sign In Error";
    }
    userCredential = await _auth.signInWithCredential(credential);
    return userCredential;
    //userCredential.user!.uid;
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      return Future(() => e.toString());
    }
  }
}
 
  //void showSnackBar(BuildContext context, String text) {
  //   final snackBar = SnackBar(content: Text(text));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

