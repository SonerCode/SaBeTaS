import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sabetas/model/musteri.dart';

import '../model/data.dart';
import '../model/diyetisyen.dart';
import '../model/food.dart';

class FireDiyetisyen extends ChangeNotifier {
  static final firestore = FirebaseFirestore.instance;
  MusteriModel? musteri;

  DataModel? myData;
  MusteriModel? get seciliMusteri => musteri;
  List<MusteriModel> musteriler = [];
  DiyetisyenModel? diyetisyen;

  static Future<void> musterisil({required String musteriuid}) async {
    await firestore
        .collection('diyetisyenler')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('müsteri')
        .doc(musteriuid)
        .delete();

    await firestore.collection('müsteriler').doc(musteriuid).delete();
  }

  DiyetisyenModel? diyetisyenD() {
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots(includeMetadataChanges: true)
        .listen((diyetci) {
      diyetisyen = DiyetisyenModel.fromJson(diyetci.data()!);
      notifyListeners();
    });
    return diyetisyen;
  }

  List<MusteriModel> getmusterilerim() {
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //burası buna döncek sonra  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('müsteri')
        .snapshots(includeMetadataChanges: true)
        .listen((musterim) {
      musteriler = musterim.docs
          .map((doc) => MusteriModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });

    return musteriler;
  }

  List<FoodModel>? yiyecekler = [];
  List<FoodModel>? kahvaltiList = [];
  List<FoodModel>? activitelist = [];
  List<FoodModel>? oglenList = [];
  List<FoodModel>? aksamList = [];
  Future<void> dgunlukData(
      {required String dayName, required String musteriuid}) async {
    try {
      final dataDoc = await firestore
          .collection('diyetisyenler')
          .doc(FirebaseAuth
              .instance.currentUser!.uid) // usercretianl current user olucak
          .collection('müsteri')
          .doc(musteriuid)
          .collection('data')
          .doc(dayName)
          .get();

      if (!dataDoc.exists) {
        myData = DataModel(alinankalori: -1, gereklikalori: -1);
        notifyListeners();
        return;
      }

      myData = DataModel.fromJson(dataDoc.data()!);
      notifyListeners();

      // ignore: empty_catches
    } catch (e) {}
  }

  Future<List<FoodModel>?> dgetistatichepsi(
      {required String dayName, required String musteriuid}) async {
    try {
      var docref = firestore
          .collection('diyetisyenler')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('müsteri')
          .doc(
              musteriuid) // burayı koyacan şimdiki login için .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('data')
          .doc(dayName);

      docref
          .collection('aksam')
          .snapshots(includeMetadataChanges: true)
          .listen((aksamyemek) {
        aksamList = aksamyemek.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });

      docref
          .collection('oglen')
          .snapshots(includeMetadataChanges: true)
          .listen((oglenyemek) {
        oglenList = oglenyemek.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });

      docref
          .collection('kahvalti')
          .snapshots(includeMetadataChanges: true)
          .listen((kahvaltilar) {
        kahvaltiList = kahvaltilar.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });

      docref
          .collection('activite')
          .snapshots(includeMetadataChanges: true)
          .listen((kahvaltilar) {
        activitelist = kahvaltilar.docs
            .map((doc) => FoodModel.fromJson(doc.data()))
            .toList();
        notifyListeners();
      });
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}
