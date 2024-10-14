// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/diyetisyen.dart';
import '../model/musteri.dart';
import '../screen/diyetisyen/dnavigasyonbari.dart';
import '../screen/musteri/ilkgiris.dart/boy_kilo_yas.dart';
import '../screen/ortak/login/login_screen.dart';

class FirebaseGiris {
  static final firestore = FirebaseFirestore.instance;
  final fireauth = FirebaseFirestore.instance;
  MusteriModel? musteri;
  DiyetisyenModel? diyetisyen;

  Future<void> createMusteri({
    required final String diyetisyenuid,
    required final String name,
    required final String password,
    required final String surname,
    required final String email,
    required final String resim,
    required final String uid,
  }) async {
    final musterii = MusteriModel(
        diyetisyenuid: diyetisyenuid,
        password: password,
        name: name,
        surname: surname,
        resim: resim,
        kilo: 0,
        boy: 0,
        email: email,
        dogumtarih: DateTime(2010),
        uid: uid);

    await firestore
        .collection('diyetisyenler')
        .doc(diyetisyenuid)
        .collection('müsteri')
        .doc(uid)
        .set(musterii.toJson());

    await firestore.collection('müsteriler').doc(uid).set(musterii.toJson());
  }

  Future<void> signIn({
    required BuildContext context,
    required String email,
    required String password,
    required bool rolune,
  }) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (rolune) {
          DocumentSnapshot<Map<String, dynamic>> musteriSnapshot =
              await FirebaseFirestore.instance
                  .collection('müsteriler')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get();

          if (musteriSnapshot.exists) {
            final Map<String, dynamic> data = musteriSnapshot.data()!;
            if (data != null) {
              musteri = MusteriModel.fromJson(data);
              await prefs.setString('email', musteri!.email);
              await prefs.setString('password', musteri!.password);
              await prefs.setBool('rolune', rolune);
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MBilgiG(diyetisyen: musteri!.diyetisyenuid),
                  ),
                );
              }
            }
          }
        } else {
          DocumentSnapshot<Map<String, dynamic>> diyetisyenSnapshot =
              await FirebaseFirestore.instance
                  .collection('diyetisyenler')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get();

          if (diyetisyenSnapshot.exists) {
            final Map<String, dynamic> data = diyetisyenSnapshot.data()!;
            if (data != null) {
              diyetisyen = DiyetisyenModel.fromJson(data);
              await prefs.setString('email', diyetisyen!.email);
              await prefs.setString('password', diyetisyen!.password);
              await prefs.setBool('rolune', rolune);
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DNavigasyon(),
                  ),
                );
              }
            }
          } else {
            // Giriş hatası
          }
        }
      }
    } catch (error) {
      if (context.mounted) {
        showErrorAlert(context);
      }
    }
  }

  Future<void> musteriSignup({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String diyetisyenuid,
    required String resim,
    required BuildContext context,
  }) async {
    try {
      // Tür kontrolü
      if (name.isEmpty ||
          surname.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          diyetisyenuid.isEmpty ||
          resim.isEmpty) {
        throw Exception('Lütfen tüm alanları doldurun.');
      }

      final UserCredential userCredential1 = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential1.user != null) {
        await createMusteri(
          diyetisyenuid: diyetisyenuid,
          name: name,
          password: password,
          surname: surname,
          email: email,
          resim: resim,
          uid: userCredential1.user!.uid,
        );
        await FirebaseAuth.instance.signOut();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? email1 = prefs.getString('email');
        String? password1 = prefs.getString('password');
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email1!, password: password1!);

        // ignore: use_build_context_synchronously
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DNavigasyon(),
        ));
      }
    } catch (e) {
      // Hata yönetimi
      // Hata mesajını kullanıcıya göstermek için alertDialog kullanılıyor
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: const Text('Lütfen Mail adresinizi kontrol ediniz!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      // Firebase oturumunu kapat
      await FirebaseAuth.instance.signOut();

      // SharedPreferences temizle
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('rolune');

      // Kullanıcıyı giriş ekranına yönlendir
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const LoginP()), // Login ekranını değiştirin
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      // Hata mesajı göstermek için bir fonksiyon kullanabilirsiniz
      showErrorAlert(context);
    }
  }

  void showErrorAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hata'),
          content: const Text(
              'Oturum Açmaya çalışırken hata ile karşılaşıldı.\n Lütfen giriş bilgilerinizi kontrol ediniz.}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
