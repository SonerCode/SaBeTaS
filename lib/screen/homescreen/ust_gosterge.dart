import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/firebasedata_provider.dart';
import 'girisekran_yazisi.dart';

class Ustgosterge extends StatefulWidget {
  const Ustgosterge({super.key});

  @override
  State<Ustgosterge> createState() => _UstgostergeState();
}

class _UstgostergeState extends State<Ustgosterge> {
  @override
  void initState() {
    super.initState();
    Provider.of<FireData>(context, listen: false)
      ..dataMiver()
      ..kendim;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FireData>(builder: (context, value, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color:
                  const Color.fromARGB(148, 134, 241, 175), // Konteyner rengi
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 30)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(left: 30)),
                    GirisMesaji(),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(left: 30)),
                Text(
                  'Merhaba ${value.kendim?.name}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            decoration: BoxDecoration(
              color: Colors.white54, // Konteyner rengi
              borderRadius: BorderRadius.circular(20), // Köşe yarıçapı
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.25), // Gölge rengi
                  spreadRadius: 5, // Yayılma yarıçapı
                  blurRadius: 7, // Bulanıklık yarıçapı
                  offset: const Offset(0, 3), // Gölgenin konumu
                ),
              ],
            ),
            child: ArcProgressBar(
                percentage: value.myData!.alinankalori *
                    100 /
                    value.myData!
                        .gereklikalori, //ilerleme yüzdesi alınan/alınmasıgereken  fazlaysa değişicek
                bottomRightWidget: Text(
                  value.myData!.gereklikalori.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                arcThickness: 15,
                handleColor: const Color(0xff799351),
                foregroundColor: const Color(0xff799351),
                centerWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Toplam Kalori",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${value.myData?.alinankalori.toString()} ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Text(
                              ' kcal',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                )),
          ),
        ],
      );
    });
  }
}
