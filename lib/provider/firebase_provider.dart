import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/diyetisyen.dart';
import '../model/mesaj.dart';
import '../model/musteri.dart';

class FirebaseProvider extends ChangeNotifier {
  List<MusteriModel> musteriler = [];
  List<Message> mesajlar = [];
  ScrollController scrollController = ScrollController();
  MusteriModel? musteri;
  DiyetisyenModel? diyetisyen;

  Future<void> getMusteriByDiyetisyenId() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return;
    }

    try {
      final musteriSnapshot = await FirebaseFirestore.instance
          .collection('müsteriler')
          .doc(currentUser.uid)
          .get();

      final musteriData = musteriSnapshot.data()!;
      musteri = MusteriModel.fromJson(musteriData);
      notifyListeners();
      await _getDiyetisyen(musteri?.diyetisyenuid);
    } catch (e) {
      // Hata durumunda uygun bir işlem yapabilirsiniz.
    }
  }

  Future<void> _getDiyetisyen(String? diyetisyenUid) async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || diyetisyenUid == null) {
      return;
    }

    try {
      final diyetisyenSnapshot = await FirebaseFirestore.instance
          .collection('diyetisyenler')
          .doc(diyetisyenUid)
          .get();

      final diyetisyenData = diyetisyenSnapshot.data();
      if (diyetisyenData != null) {
        diyetisyen = DiyetisyenModel.fromJson(diyetisyenData);
        notifyListeners();
      }
    } catch (e) {
      // Hata durumunda uygun bir işlem yapabilirsiniz.
    }
  }

  Future<MusteriModel?> getbydiyetisyenid() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    try {
      FirebaseFirestore.instance
          .collection('müsteriler')
          .doc(currentUser.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((musterim) {
        final data = musterim.data();
        if (data != null) {
          musteri = MusteriModel.fromJson(data);
          notifyListeners();
        }
      });

      FirebaseFirestore.instance
          .collection('diyetisyenler')
          .doc(musteri?.diyetisyenuid)
          .collection('müsteri')
          .doc(currentUser.uid)
          .snapshots(includeMetadataChanges: true)
          .listen((diyetisyeni) {
        final data = diyetisyeni.data();
        if (data != null) {
          diyetisyen = DiyetisyenModel.fromJson(data);
          notifyListeners();
        }
      });

      // Diğer işlemler
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }

  get authStateChanges => null;
  List<MusteriModel> getmusteriler() {
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

  MusteriModel? getmusteribyid(String musteriuid) {
    // bu kod patlayabilir dikkat!!
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(FirebaseAuth
            .instance.currentUser!.uid) //burası diyetisyenid olarak değişecek
        .collection('müsteri')
        .doc(musteriuid)
        .snapshots(includeMetadataChanges: true)
        .listen((musterim) {
      musteri = MusteriModel.fromJson(musterim.data()!);
      notifyListeners();
    });

    return musteri;
  }

  List<Message> getMesajlarD(String alanid) {
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burası buna döncek sonra  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('müsteri')
        .doc(alanid)
        .collection('message')
        .orderBy('tarih', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((message) {
      mesajlar =
          message.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();

      scrollDown();
    });
    return mesajlar;
  }

  List<Message> getMesajlarM(String diyetisyenuid) {
    FirebaseFirestore.instance
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burası buna döncek sonra  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('message')
        .orderBy('tarih', descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((message) {
      mesajlar =
          message.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();

      scrollDown();
    });
    return mesajlar;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
}

class FirebaseFirestoreService {
  static final firestore = FirebaseFirestore.instance;

  static Future<void> mesajiyollaD({
    required String mesaj,
    required String alanid,
  }) async {
    final gmesaj = Message(
        // giden mesaj bu karışmasın
        mesaj: mesaj,
        tarih: DateTime.now(),
        alan: alanid,
        gonderen: FirebaseAuth.instance.currentUser!
            .uid //şuan ki logindeki kişi düzenlenecek FirebaseAuth.instance.currentUser!.uid,
        );
    await _mesajiekleD(alanid, gmesaj);
  }

  static Future<void> _mesajiekleD(
    String alanid,
    Message gmesaj,
  ) async {
    await firestore
        .collection('diyetisyenler')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('müsteri')
        .doc(alanid)
        .collection('message')
        .add(gmesaj.toJson());
  }

  static Future<void> mesajiyollaM({
    required String mesaj,
    required String alanid,
  }) async {
    final gmesaj = Message(
        // giden mesaj bu karışmasın
        mesaj: mesaj,
        tarih: DateTime.now(),
        alan: alanid,
        gonderen: FirebaseAuth.instance.currentUser!
            .uid //şuan ki logindeki kişi düzenlenecek FirebaseAuth.instance.currentUser!.uid,
        );
    await _mesajiekleM(alanid, gmesaj);
  }

  static Future<void> _mesajiekleM(
    String alanid,
    Message gmesaj,
  ) async {
    await firestore
        .collection('diyetisyenler')
        .doc(alanid)
        .collection('müsteri')
        .doc(FirebaseAuth.instance.currentUser!
            .uid) // burayı koyacan şimdiki login için  .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('message')
        .add(gmesaj.toJson());
  }
}
