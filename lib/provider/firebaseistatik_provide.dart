// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/data.dart';
import '../model/food.dart';
import '../model/musteri.dart';

class FireIstatik extends ChangeNotifier {
  static final firestore = FirebaseFirestore.instance;
  DataModel? myData;
  MusteriModel? musteri;

  List<FoodModel>? yiyecekler = [];
  List<FoodModel>? kahvaltiList = [];
  List<FoodModel>? oglenList = [];
  List<FoodModel>? activiteler = [];
  List<FoodModel>? aksamList = [];
  Future<void> gunlukData({required String dayName}) async {
    try {
      final musteriDoc = await firestore
          .collection('müsteriler')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (!musteriDoc.exists) {
        // Müşteri belgesi bulunamazsa
        return;
      }

      final diyetisyenUID = musteriDoc.data()!['diyetisyenuid'];

      final dataDoc = await firestore
          .collection('diyetisyenler')
          .doc(diyetisyenUID)
          .collection('müsteri')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data')
          .doc(dayName)
          .get();

      if (!dataDoc.exists) {
        myData = DataModel(alinankalori: -1, gereklikalori: -1);
        notifyListeners();
        return;
      }

      myData = DataModel.fromJson(dataDoc.data()!);
      notifyListeners(); // Değişikliği bildir
      // ignore: duplicate_ignore
      // ignore: empty_catches
    } catch (e) {}
  }

  List<FoodModel>? getistatikfoodKahvalti({required String dayName}) {
    try {
      firestore
          .collection('müsteriler')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((musterim) {
        var data = musterim.data();
        if (data != null) {
          musteri = MusteriModel.fromJson(data);
          notifyListeners();
        } else {
          // Null durumu için işlem
        }
      });

      firestore
          .collection('diyetisyenler')
          .doc(musteri?.diyetisyenuid)
          .collection('müsteri')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data')
          .doc(dayName)
          .collection('kahvalti')
          .snapshots(includeMetadataChanges: true)
          .listen((kahvaltilar) {
        kahvaltiList = kahvaltilar.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
    } catch (e) {}

    return kahvaltiList;
  }

  List<FoodModel>? getistatikfoodOglen({required String dayName}) {
    try {
      firestore
          .collection('müsteriler')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((musterim) {
        var data = musterim.data();
        if (data != null) {
          musteri = MusteriModel.fromJson(data);
          notifyListeners();
        } else {
          // Null durumu için işlem
        }
      });

      firestore
          .collection('diyetisyenler')
          .doc(musteri?.diyetisyenuid)
          .collection('müsteri')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data')
          .doc(dayName)
          .collection('oglen')
          .snapshots(includeMetadataChanges: true)
          .listen((oglenyemek) {
        oglenList = oglenyemek.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
    } catch (e) {}

    return oglenList;
  }

  List<FoodModel>? getistatikactivite({required String dayName}) {
    try {
      firestore
          .collection('müsteriler')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((musterim) {
        var data = musterim.data();
        if (data != null) {
          musteri = MusteriModel.fromJson(data);
          notifyListeners();
        } else {
          // Null durumu için işlem
        }
      });

      firestore
          .collection('diyetisyenler')
          .doc(musteri?.diyetisyenuid)
          .collection('müsteri')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data')
          .doc(dayName)
          .collection('activite')
          .snapshots(includeMetadataChanges: true)
          .listen((oglenyemek) {
        activiteler = oglenyemek.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
    } catch (e) {}

    return activiteler;
  }

  List<FoodModel>? getistatikfoodAksam({required String dayName}) {
    try {
      firestore
          .collection('müsteriler')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((musterim) {
        var data = musterim.data();
        if (data != null) {
          musteri = MusteriModel.fromJson(data);
          notifyListeners();
        } else {
          // Null durumu için işlem
        }
      });

      firestore
          .collection('diyetisyenler')
          .doc(musteri?.diyetisyenuid)
          .collection('müsteri')
          .doc(FirebaseAuth.instance.currentUser!
              .uid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data')
          .doc(dayName)
          .collection('aksam')
          .snapshots(includeMetadataChanges: true)
          .listen((aksamyemek) {
        aksamList = aksamyemek.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
    } catch (e) {}

    return aksamList;
  }
}
