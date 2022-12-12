import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<String> route() async {
    User? user = _firebaseAuth.currentUser;
    String rol = '';
    var kk = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rol') == "Estudiante") {
          rol = 'Estudiante';
        } else {
          rol = 'Admin';
        }
      } else {
        rol = 'NA';
      }
    }).catchError((e) {
      rol = 'Error';
    });
    return rol;
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore =
        FirebaseFirestore.instance;
    var user = _firebaseAuth.currentUser;
    CollectionReference ref = firebaseFirestore.collection('usuarios');
    ref.doc(user!.uid).set({'email': email, 'rol': rool});
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String rol}) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rol)})
          .catchError((e) {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
