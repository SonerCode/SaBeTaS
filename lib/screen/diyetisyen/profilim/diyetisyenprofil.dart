import 'package:flutter/material.dart';

import '../../../model/diyetisyen.dart';
import '../../../provider/firebaseauth_service.dart';
import '../Home/musterisil/musteri_sil.dart';
import '../musteri_add/musteri_add.dart';

// ignore: must_be_immutable
class DiyetisyenProfil extends StatefulWidget {
  DiyetisyenProfil({super.key, required this.kendim});
  DiyetisyenModel? kendim;

  @override
  State<DiyetisyenProfil> createState() => _MusteriProfilState();
}

class _MusteriProfilState extends State<DiyetisyenProfil> {
  @override
  Widget build(BuildContext context) {
    double heig = MediaQuery.of(context).size.height;
    double widt = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
                height: heig / 2.65,
                width: widt,
                decoration: BoxDecoration(
                  color: Colors.white, // Konteyner rengi
                  borderRadius: BorderRadius.circular(20), // Köşe yarıçapı
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.55), // Gölge rengi
                      spreadRadius: 5, // Yayılma yarıçapı
                      blurRadius: 7, // Bulanıklık yarıçapı
                      offset: const Offset(0, 3), // Gölgenin konumu
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                      child: Text(
                        'Profil',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: heig / 3.5,
                        width: widt / 1.75,
                        decoration: BoxDecoration(
                          color: Colors.grey, // Konteyner rengi
                          borderRadius:
                              BorderRadius.circular(180), // Köşe yarıçapı
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.55), // Gölge rengi
                              spreadRadius: 5, // Yayılma yarıçapı
                              blurRadius: 7, // Bulanıklık yarıçapı
                              offset: const Offset(0, 3), // Gölgenin konumu
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 0,
                          backgroundColor: Colors.greenAccent,
                          backgroundImage: NetworkImage(
                              widget.kendim!.resim), //user image olucak
                        ),
                      ),
                    )
                  ],
                )),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  decoration: Boxum(),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    leading: const Icon(Icons.add, size: 40),
                    title: const Text(
                      'Müşteri Ekle',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MusteriAdd()),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: Boxum(),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    leading: const Icon(Icons.delete, size: 40),
                    title: const Text(
                      'Müşteri Sil',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MusteriSil()),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: Boxum(),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    leading: const Icon(Icons.privacy_tip, size: 40),
                    title: const Text(
                      'Gizlilik',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // Dialog içeriğini oluştur
                          return AlertDialog(
                            title: const Text('Gizlilik Politikası'),
                            content: const SingleChildScrollView(
                              child: Text(
                                'SaBeTaS olarak, gizliliğinizi korumaya ve kişisel bilgilerinizin güvenliğini sağlamaya kendimizi adadık. Bu gizlilik politikası, mobil uygulamamızı kullandığınızda verilerinizi nasıl topladığımızı, kullandığımızı, ifşa etmeğimizi ve koruduğumuzu özetlemektedir. Hizmetlerimizi iyileştirmek, kullanıcı deneyiminizi geliştirmek ve bu politikada açıklanan diğer amaçlar için bilgi topluyoruz. Kişisel bilgilerinizi özenle ve yürürlükteki yasa ve yönetmeliklere uygun olarak ele almayı taahhüt ediyoruz. Uygulamamızı kullanarak, bilgilerin bu politikaya uygun olarak toplanmasını ve kullanılmasını kabul etmiş olursunuz.',
                              ),
                            ),
                            actions: <Widget>[
                              // Dialog kapatma düğmesi
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Dialogu kapat
                                },
                                child: const Text('Kapat'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: Boxum(),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    leading: const Icon(Icons.logout, size: 40),
                    title: const Text(
                      'Çıkış Yap',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      FirebaseGiris().signOut(context);
                    },
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    )));
  }
}

// ignore: non_constant_identifier_names
BoxDecoration Boxum() {
  return BoxDecoration(
    color: Colors.white, // Konteyner rengi
    borderRadius: BorderRadius.circular(10), // Köşe yarıçapı
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.55), // Gölge rengi
        spreadRadius: 5, // Yayılma yarıçapı
        blurRadius: 7, // Bulanıklık yarıçapı
        offset: const Offset(0, 3), // Gölgenin konumu
      ),
    ],
  );
}
