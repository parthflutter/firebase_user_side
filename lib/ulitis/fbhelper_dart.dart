import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_user_side/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebasehelper {
  static Firebasehelper fireHelper = Firebasehelper._();

  Firebasehelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth fireauth = FirebaseAuth.instance;

  signUP({required email, required password}) async {
    await fireauth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("Login Success !"))
        .catchError((e) => print("Failed : $e"));
  }

  bool status = false;
  String msg = '';

  Future<String> signIn({required email, required password}) async {
    return await fireauth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => "success")
        .catchError((e) => '${e}');
  }

  checkUser() {
    User? user = fireauth.currentUser;
    return user != null;
  }

  Future<bool?> logout() async {
    bool? check;
    FirebaseAuth.instance
        .signOut()
        .then((value) => check = true)
        .catchError((e) => check = false);
    await GoogleSignIn().signOut().then((value) => check = true);
    return check;
  }

  Future<String?> google_SignIn() async {
    String? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? auth = await user!.authentication;
    var crd = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    await fireauth
        .signInWithCredential(crd)
        .then((value) => msg = "Success")
        .catchError((e) => msg = '${e}');
    return msg;
  }

  Future<Map> userDetails() async {
    User? user = await fireauth.currentUser;
    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;
    Map m1 = {'email': email, 'img': img, 'name': name};
    return m1;
  }

  void insertitem({
    required Name,
    required Quantity,
    required Category,
    required Price,
    required Image,
  }) async {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    await firestore.collection("userdata").doc("$uid").collection("cart").add({
      "Name": Name,
      "Quantity": Quantity,
      "Category": Category,
      "Price": Price,
      "Image":Image,

    });
  }
  void cartitem({
    required Name,
    required Quantity,
    required Category,
    required Price,
    required Image,
  }) async {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    await firestore.collection("userdata").doc("$uid").collection("cart").add({
      "Name": Name,
      "Quantity": Quantity,
      "Category": Category,
      "Price": Price,
      "Image": Image,
    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> readitem() {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    return firestore.collection("item").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readcartitem() {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    return firestore.collection("userdata").doc("$uid").collection("cart").snapshots();
  }
  // Buy Cart Item;


  void buyinsertitem(
      m1
      ) async {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    await firestore.collection("userdata").doc("$uid").collection("buy").add({
      "Name": "${m1['Name']}",
      "Quantity": "${m1['Quantity']}",
      "Category":  "${m1['Category']}",
      "Price":  "${m1['Price']}",
      "Image": "${m1['Image']}",

    });
  }
  void buyitem({
    required Name,
    required Quantity,
    required Category,
    required Price,
    required Image,
  }) async {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    await firestore.collection("userdata").doc("$uid").collection("buy").add({
      "Name": Name,
      "Quantity": Quantity,
      "Category": Category,
      "Price": Price,
      "Image": Image,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readbuyitem(){
    User?user=fireauth.currentUser;
    String uid=user!.uid;
    return firestore.collection("userdata").doc("$uid").collection("buy").snapshots();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> buyreaditem() {
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    return firestore.collection("userdata").snapshots();
  }
  void delete(String key){
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    firestore.collection("userdata").doc("$uid").collection("cart").doc(key).delete();
}

  void buydelete(String key){
    User? user = fireauth.currentUser;
    String uid = user!.uid;
    firestore.collection("userdata").doc("$uid").collection("buy").doc(key).delete();
  }
}
