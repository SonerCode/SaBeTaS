import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUpdate {
  static final firestore = FirebaseFirestore.instance;
  static final fireauth = FirebaseAuth.instance;

  static Future<void> updateMusteri(
      {required final int boy,
      required final int kilo,
      required final DateTime dogumtarih,
      required final String diyetisyenuid}) async {
    await firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burası fireauth.currentUser!.uid bu olucak
        .update({'boy': boy, 'kilo': kilo, 'dogumtarih': dogumtarih});
    await firestore
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burası fireauth.currentUser!.uid bu olucak
        .update({'boy': boy, 'kilo': kilo, 'dogumtarih': dogumtarih});
  }

  static Future<void> updateMusteriVki(
      {required final int boy,
      required final int kilo,
      required final String diyetisyenuid}) async {
    await firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burası fireauth.currentUser!.uid bu olucak
        .update({'boy': boy, 'kilo': kilo});
    await firestore
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burası fireauth.currentUser!.uid bu olucak
        .update({'boy': boy, 'kilo': kilo});
  }
}
