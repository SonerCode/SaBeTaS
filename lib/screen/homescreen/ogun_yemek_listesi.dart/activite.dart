import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sabetas/provider/firebasefoods.dart';

import '../../../model/food.dart';
import '../../musteri/activite/activite_add.dart';
import '../../musteri/activite/yapilanactivite.dart';

// ignore: must_be_immutable
class Activite extends StatefulWidget {
  Activite({
    required this.diyetisyenuid,
    super.key,
  });
  String diyetisyenuid;

  @override
  // ignore: library_private_types_in_public_api
  _ActiviteState createState() => _ActiviteState();
}

class _ActiviteState extends State<Activite> {
  @override
  void initState() {
    super.initState();
    Provider.of<FireFood>(context, listen: false)
        .activitegetir(diyetisyenuid: widget.diyetisyenuid);
  }

  List<FoodModel?> searchList = [];
  @override
  Widget build(BuildContext context) {
    final heig = MediaQuery.of(context).size.height;
    return Consumer<FireFood>(
      builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  // ignore: prefer_const_constructors
                  color: Color.fromARGB(148, 134, 241, 175), // Konteyner rengi
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 1)),
                    const Text(
                      'AKTİVİTE',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchList.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ActiviteAdd(
                                    searchList: searchList,
                                    ogun: 'activite',
                                  )),
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Konteyner rengi
                  borderRadius: BorderRadius.circular(20), // Köşe yarıçapı
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.015), // Gölge rengi
                      spreadRadius: 5, // Yayılma yarıçapı
                      blurRadius: 7, // Bulanıklık yarıçapı
                      offset: const Offset(0, 3), // Gölgenin konumu
                    ),
                  ],
                ),
                height: value.activiteList!.length * 70000 / heig,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: value.activiteList!.length,
                  itemBuilder: (context, index) {
                    return Yapilanactivite(
                      food: value.activiteList![index],
                      ogun: 'activite',
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 5,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
