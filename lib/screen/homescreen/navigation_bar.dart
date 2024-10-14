import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/firebase_provider.dart';
import '../diyetisyen/dnavigasyonbari.dart';
import '../musteri/chat/mchat_screen.dart';
import '../musteri/istatistik_sayfasi/istatistik.dart';
import '../musteri/profil_Page.dart/musteriprofil.dart';
import 'home_screen.dart';

class MNavigationBarim extends StatefulWidget {
  const MNavigationBarim({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MNavigationBarimState createState() => _MNavigationBarimState();
}

class _MNavigationBarimState extends State<MNavigationBarim> {
  @override
  void initState() {
    super.initState();

    Provider.of<FirebaseProvider>(context, listen: false)
        .getMusteriByDiyetisyenId();
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(builder: (context, value, child) {
      final musterim = value.musteri;

      // Eğer musteri null ise boş bir liste gösterelim
      final List<Widget> pages = (musterim == null)
          ? [
              const BosEkran(), // Ana Ekran sayfası
              const BosEkran(), // Boş ekran sayfası
              const BosEkran(), // Boş ekran sayfası
              const BosEkran(), // Müşteri Profil sayfası
            ]
          : [
              HomeScreenM(
                  diyetisyenuid: musterim.diyetisyenuid), // Ana Ekran sayfası
              const StatistikPage(), // İstatistik sayfası
              MChatScreen(
                  diyetisyenuid: musterim.diyetisyenuid), // Mesaj sayfası
              MusteriProfil(
                  musteriresim: musterim.resim,
                  diyetisyen: musterim.diyetisyenuid), // Müşteri Profil sayfası
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
    });
  }
}
