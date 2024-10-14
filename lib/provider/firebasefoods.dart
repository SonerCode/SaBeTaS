// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';

import '../model/food.dart';
import '../model/musteri.dart';

class FireFood extends ChangeNotifier {
  static final firestore = FirebaseFirestore.instance;


  List<FoodModel> foodlistem = [];
  List<FoodModel>? yiyecekler = [];
  List<FoodModel>? activite = [];
  List<FoodModel>? kahvaltiList = [];
  List<FoodModel>? oglenList = [];
  List<FoodModel>? activiteList = [];
  List<FoodModel>? aksamList = [];

  static Future<void> foodeklebana({
    required String ogun,
    required FoodModel food,
  }) async {
    await _foodeklebana(ogun, food);
  }

  static Future<void> _foodeklebana(
    String ogun,
    FoodModel yemek,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> musteriSnapshot = await firestore
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //userCredential.user!.uid  olucak düzgün database yapinca
        .get();
    final MusteriModel data = MusteriModel.fromJson(musteriSnapshot.data()!);
  final now = DateTime.now();
    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection(ogun)
        .doc(yemek.name)
        .set(yemek.toJson());

    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .update({'alinankalori': FieldValue.increment(yemek.fkalori)});
  }

  static Future<void> activiteklebana({
    required String ogun,
    required FoodModel food,
  }) async {
    await _activiteklebana(ogun, food);
  }

  static Future<void> _activiteklebana(
    String ogun,
    FoodModel yemek,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> musteriSnapshot = await firestore
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //userCredential.user!.uid  olucak düzgün database yapinca
        .get();
    final MusteriModel data = MusteriModel.fromJson(musteriSnapshot.data()!);
  final now = DateTime.now();
    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection(ogun)
        .doc(yemek.name)
        .set(yemek.toJson());

    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .update({'alinankalori': FieldValue.increment(-1 * yemek.fkalori)});
  }

  static Future<void> activitesilbenden({
    required String ogun,
    required FoodModel food,
  }) async {
    await _activitesilbenden(ogun, food);
  }

  static Future<void> _activitesilbenden(
    String ogun,
    FoodModel aktivite,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> musteriSnapshot = await firestore
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //userCredential.user!.uid  olucak düzgün database yapinca
        .get();
    final MusteriModel data = MusteriModel.fromJson(musteriSnapshot.data()!);
  final now = DateTime.now();
    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection(ogun)
        .doc(aktivite.name)
        .delete();

    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .update({'alinankalori': FieldValue.increment(aktivite.fkalori)});
  }

  static Future<void> foodsilbenden({
    required String ogun,
    required FoodModel food,
  }) async {
    await _foodsilbenden(ogun, food);
  }

  static Future<void> _foodsilbenden(
    String ogun,
    FoodModel yemek,
  ) async {
    DocumentSnapshot<Map<String, dynamic>> musteriSnapshot = await firestore
        .collection('müsteriler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) //userCredential.user!.uid  olucak düzgün database yapinca
        .get();
    final MusteriModel data = MusteriModel.fromJson(musteriSnapshot.data()!);
  final now = DateTime.now();
    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection(ogun)
        .doc(yemek.name)
        .delete();

    await firestore
        .collection('diyetisyenler')
        .doc(data.diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .update({'alinankalori': FieldValue.increment(-1 * yemek.fkalori)});
  }

  List<FoodModel>? foodgetirKahvalti({required String diyetisyenuid}) {
      final now = DateTime.now();
    firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection('kahvalti')
        .snapshots(includeMetadataChanges: true)
        .listen((kahvaltilar) {
      kahvaltiList = kahvaltilar.docs
          .map((doc) => FoodModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });

    return kahvaltiList;
  }

  List<FoodModel>? yiyeceklerim() {
    firestore
        .collection('yiyecek')
        .snapshots(includeMetadataChanges: true)
        .listen((kahvaltilar) {
      yiyecekler = kahvaltilar.docs
          .map((doc) => FoodModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });

    return yiyecekler;
  }

  List<FoodModel>? activiteler() {
    firestore
        .collection('aktivite')
        .snapshots(includeMetadataChanges: true)
        .listen((kahvaltilar) {
      yiyecekler = kahvaltilar.docs
          .map((doc) => FoodModel.fromJson(doc.data()))
          .toList();
      notifyListeners();
    });

    return activite;
  }

  List<FoodModel>? foodgetirOglen({required String diyetisyenuid}) {
      final now = DateTime.now();
    firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection('oglen')
        .snapshots(includeMetadataChanges: true)
        .listen((oglenyemek) {
      oglenList =
          oglenyemek.docs.map((doc) => FoodModel.fromJson(doc.data())).toList();
      notifyListeners();
    });

    return oglenList;
  }

  List<FoodModel>? activitegetir({required String diyetisyenuid}) {
      final now = DateTime.now();
    firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection('activite')
        .snapshots(includeMetadataChanges: true)
        .listen((activitem) {
      activiteList =
          activitem.docs.map((doc) => FoodModel.fromJson(doc.data())).toList();
      notifyListeners();
    });

    return activiteList;
  }

  List<FoodModel>? foodgetirAksam({required String diyetisyenuid}) {
      final now = DateTime.now();
    firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('data')
        .doc(DateFormat('yyyyMMdd').format(now))
        .collection('aksam')
        .snapshots(includeMetadataChanges: true)
        .listen((aksamyemek) {
      aksamList =
          aksamyemek.docs.map((doc) => FoodModel.fromJson(doc.data())).toList();
      notifyListeners();
    });

    return aksamList;
  }
}
