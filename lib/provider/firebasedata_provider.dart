import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/data.dart';
import '../model/musteri.dart';

class FireData extends ChangeNotifier {
  DataModel? myData = DataModel(alinankalori: 0, gereklikalori: 0);
  MusteriModel? kendim;
  static final firestore = FirebaseFirestore.instance;

  Future<void> dataMiver() async {
    try {
      // Kullanıcı verilerini al
      DocumentSnapshot<Map<String, dynamic>> musteriSnapshot = await firestore
          .collection('müsteriler')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final MusteriModel data = MusteriModel.fromJson(musteriSnapshot.data()!);
      kendim = data;
      notifyListeners();
      // Günlük verileri al
      String dateString = DateFormat('yyyyMMdd').format(DateTime.now());
      CollectionReference dataRef = firestore
          .collection('diyetisyenler')
          .doc(data.diyetisyenuid)
          .collection('müsteri')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data');

      DocumentReference docRef = dataRef.doc(dateString);

      dataRef.doc(dateString).snapshots().listen((docSnapshot) {
        if (docSnapshot.exists) {
          if (docSnapshot.data() != null) {
            myData =
                DataModel.fromJson(docSnapshot.data()! as Map<String, dynamic>);
            notifyListeners();
          } else {
            myData = DataModel.fromJson(getDefaultDataModelJson());
            notifyListeners();

            docRef.set(getDefaultDataModelJson());
          }
        } else {
          myData = DataModel.fromJson(getDefaultDataModelJson());

          notifyListeners();

          docRef.set(getDefaultDataModelJson());
        }
      });
      // ignore: empty_catches
    } catch (error) {}
  }

  getDefaultDataModelJson() {
    return DataModel(alinankalori: 0, gereklikalori: 1950).toJson();
  }
}
