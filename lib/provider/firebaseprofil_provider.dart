import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/diyetisyen.dart';
import '../model/musteri.dart';

class FireProfil extends ChangeNotifier {
  static final firestore = FirebaseFirestore.instance;
  MusteriModel? musteri;
  DiyetisyenModel? diyetisyen;

  MusteriModel? kendimM() {
    FirebaseFirestore.instance
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((kendim) {
      musteri = MusteriModel.fromJson(kendim.data()!);
      notifyListeners();
    });

    return musteri;
  }

  DiyetisyenModel? diyetisyenM(String? diyetisyenuid) {
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(
            diyetisyenuid) //burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((diyetci) {
      diyetisyen = DiyetisyenModel.fromJson(diyetci.data()!);
      notifyListeners();
    });
    return diyetisyen;
  }

  DiyetisyenModel? diyetisyenD() {
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((diyetci) {
      diyetisyen = DiyetisyenModel.fromJson(diyetci.data()!);
      notifyListeners();
    });
    return diyetisyen;
  }
}
