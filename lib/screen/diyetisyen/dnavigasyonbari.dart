import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/firebase_diyetisyen_provider.dart';
import '../../provider/firebase_provider.dart';
import 'Home/MusteriListesi/musterilerim.dart';
import 'Home/istaticticpage/musterimin_istatistic.dart';
import 'chat/dchat_screen.dart';
import 'profilim/diyetisyenprofil.dart';

class DNavigasyon extends StatefulWidget {
  const DNavigasyon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DNavigasyonState createState() => _DNavigasyonState();
}

class _DNavigasyonState extends State<DNavigasyon> {
  @override
  void initState() {
    super.initState();

    Provider.of<FirebaseProvider>(context, listen: false)
        .getMusteriByDiyetisyenId();
    Provider.of<FireDiyetisyen>(context, listen: false)
      ..musteri
      ..diyetisyenD();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<FireDiyetisyen>(
      builder: (context, fireDiyetisyen, child) {
        final musteri = fireDiyetisyen.musteri;
        final kendim = fireDiyetisyen.diyetisyen;

        // Eğer musteri null ise boş bir liste gösterelim
        final List<Widget> pages = musteri == null
            ? [
                const MusterilerimD(),
                const BosEkran(),
                const BosEkran(),
                DiyetisyenProfil(kendim: kendim)
              ]
            : [
                const MusterilerimD(),
                MStatistikPage(musteriuid: musteri.uid),
                ChatScreen(musteriuid: musteri.uid),
                DiyetisyenProfil(kendim: kendim),
              ];

        return SafeArea(
          child: Scaffold(
            body: pages[_selectedIndex],
            bottomNavigationBar: Container(
              color: Colors.black,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GNav(
                    gap: 8,
                    backgroundColor: Colors.black,
                    activeColor: Colors.white,
                    color: Colors.white,
                    tabBackgroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    tabs: const [
                      GButton(
                        icon: Icons.home_filled,
                        text: 'Ana Ekran',
                      ),
                      GButton(
                        icon: Icons.analytics_outlined,
                        text: 'İstatistik',
                      ),
                      GButton(
                        icon: Icons.message,
                        text: 'Mesaj',
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Hesabım',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  )),
            ),
          ),
        );
      },
    );
  }
}

class BosEkran extends StatelessWidget {
  const BosEkran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white54, // Konteyner rengi
            borderRadius: BorderRadius.circular(10), // Köşe yarıçapı
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.45), // Gölge rengi
                spreadRadius: 5, // Yayılma yarıçapı
                blurRadius: 7, // Bulanıklık yarıçapı
                offset: const Offset(0, 3), // Gölgenin konumu
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Müsteri Bilgisi Görebilmek için Lütfen bir Müşteri seçiniz!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              )),
              Icon(
                Icons.cancel_presentation_rounded,
                size: 135,
              )
            ],
          )),
    ));
  }
}
