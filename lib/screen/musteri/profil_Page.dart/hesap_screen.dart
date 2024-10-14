import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebaseprofil_provider.dart';
import '../../homescreen/navigation_bar.dart';

// ignore: must_be_immutable
class HesapEkrani extends StatefulWidget {
  HesapEkrani({super.key, required this.resim, required this.diyetisyen});
  String resim;
  String diyetisyen;

  @override
  State<HesapEkrani> createState() => _HesapEkraniState();
}

class _HesapEkraniState extends State<HesapEkrani> {
  @override
  void initState() {
    super.initState();

    Provider.of<FireProfil>(context, listen: false)
      ..kendimM()
      ..diyetisyenM(widget.diyetisyen);
  }

  @override
  Widget build(BuildContext context) {
    int yashesapla(DateTime dogumtarih) {
      final simdi = DateTime.now();
      final yas = simdi.year - dogumtarih.year;
      final ay1 = simdi.month;
      final ay2 = dogumtarih.month;
      if (ay2 > ay1 || (ay1 == ay2 && simdi.day < dogumtarih.day)) {
        return yas - 1;
      } else {
        return yas;
      }
    }

    double calculateVki(int weight, int height) {
      double heights = height / 100;
      return double.parse((weight / (heights * heights)).toStringAsFixed(2));
    }

    double heig = MediaQuery.of(context).size.height;
    double widt = MediaQuery.of(context).size.width;
    return Consumer<FireProfil>(
      builder: (context, value, child) {
        return SafeArea(
            child: Scaffold(
                body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding:
                              EdgeInsets.only(top: 15, right: 15, left: 15),
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
                                  color: Colors.grey
                                      .withOpacity(0.55), // Gölge rengi
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
                                  widget.resim), //user image olucak
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Container(
                    height: heig / 20,
                    width: widt,
                    decoration: BoxDecoration(
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
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Adı : ${value.musteri?.name} ${value.musteri?.surname}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    height: heig / 20,
                    width: widt,
                    decoration: BoxDecoration(
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
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Email : ${value.musteri?.email}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    height: heig / 20,
                    width: widt,
                    decoration: BoxDecoration(
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
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Yaş : ${value.musteri?.dogumtarih != null ? yashesapla(value.musteri!.dogumtarih) : ' '}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    height: heig / 20,
                    width: widt,
                    decoration: BoxDecoration(
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
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Diyetisyen adı : ${value.diyetisyen?.name ?? ''}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                  child: Container(
                    height: heig / 20,
                    width: widt,
                    decoration: BoxDecoration(
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
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        Text(
                          'Vki : ${value.musteri?.boy != null ? calculateVki(value.musteri!.kilo, value.musteri!.boy) : ' '}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MNavigationBarim()),
                    );
                  },
                  child: Container(
                    height: heig / 20,
                    width: widt,
                    decoration: BoxDecoration(
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
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Geriye Git',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        )));
      },
    );
  }
}
