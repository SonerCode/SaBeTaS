import 'package:flutter/material.dart';

import 'ogun_yemek_listesi.dart/activite.dart';
import 'ogun_yemek_listesi.dart/aksam_yemeklist.dart';
import 'ogun_yemek_listesi.dart/kahvalti_yemeklist.dart';
import 'ogun_yemek_listesi.dart/oglen_yemeklist.dart';
import 'ust_gosterge.dart';

// ignore: must_be_immutable
class HomeScreenM extends StatefulWidget {
  HomeScreenM({super.key, required this.diyetisyenuid});
  String diyetisyenuid;

  @override
  State<HomeScreenM> createState() => _HomeScreenMState();
}

class _HomeScreenMState extends State<HomeScreenM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const Ustgosterge(),
            const Padding(padding: EdgeInsets.only(top: 40)),
            KahvaltimL(
              diyetisyenuid: widget.diyetisyenuid,
            ),
            OglenL(
              diyetisyenuid: widget.diyetisyenuid,
            ),
            AksamL(
              diyetisyenuid: widget.diyetisyenuid,
            ),
            Activite(diyetisyenuid: widget.diyetisyenuid)
          ],
        ),
      )),
    );
  }
}
