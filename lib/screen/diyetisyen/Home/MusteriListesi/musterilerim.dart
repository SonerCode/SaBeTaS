import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../provider/firebase_diyetisyen_provider.dart';
import '../../../homescreen/girisekran_yazisi.dart';

class MusterilerimD extends StatefulWidget {
  const MusterilerimD({super.key});

  @override
  State<MusterilerimD> createState() => _MusterilerimDState();
}

class _MusterilerimDState extends State<MusterilerimD> {
  int secili = -1;

  @override
  void initState() {
    super.initState();
    Provider.of<FireDiyetisyen>(context, listen: false)
      ..getmusterilerim()
      ..diyetisyenD();

    SharedPreferences.getInstance().then((prefs) {
      int? storedSecili = prefs.getInt('secili_index');
      setState(() {
        if (storedSecili != null) {
          if (Provider.of<FireDiyetisyen>(context, listen: false)
                  .musteriler
                  .length >=
              storedSecili) {
            secili = storedSecili;
            prefs.remove('secili');
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FireDiyetisyen>(builder: (context, value, child) {
      return Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white54, // Konteyner rengi
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
                    'Merhaba ${value.diyetisyen?.name}',
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
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.musteriler.length,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 5);
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => value.musteriler.isEmpty
                  ? const SizedBox(
                      height: 1,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white54, // Konteyner rengi
                        borderRadius:
                            BorderRadius.circular(10), // Köşe yarıçapı
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.45), // Gölge rengi
                            spreadRadius: 5, // Yayılma yarıçapı
                            blurRadius: 7, // Bulanıklık yarıçapı
                            offset: const Offset(0, 3), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            secili = index;

                            SharedPreferences.getInstance().then((prefs) {
                              prefs.setInt('secili_index', secili);
                            });

                            value.musteri = value.musteriler[index];
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        leading: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(value.musteriler[index].resim),
                            ),
                          ],
                        ),
                        title: Text(
                          value.musteriler[index].name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing:
                            Provider.of<FireDiyetisyen>(context, listen: false)
                                        .musteri !=
                                    null
                                ? const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Icon(
                                      Icons.square,
                                      color: Colors.green,
                                      size: 25,
                                    ))
                                : const SizedBox(),
                      ),
                    ),
            ),
          )
        ],
      ));
    });
  }
}
