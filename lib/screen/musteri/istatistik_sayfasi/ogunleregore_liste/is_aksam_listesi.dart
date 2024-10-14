import 'package:flutter/material.dart';

import '../../../../model/food.dart';
import '../FoodsItem.dart';

// ignore: must_be_immutable
class IsAksam extends StatefulWidget {
  IsAksam({super.key, required this.aksamim});
  List<FoodModel>? aksamim;

  @override
  State<IsAksam> createState() => _IsAksamState();
}

class _IsAksamState extends State<IsAksam> {
  @override
  Widget build(BuildContext context) {
    final heig = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(148, 134, 241, 175), // Konteyner rengi
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
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AKŞAM',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
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
            height: widget.aksamim!.isEmpty
                ? 1 * 50000 / heig
                : widget.aksamim!.length * 60000 / heig,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount: widget.aksamim!.isEmpty ? 1 : widget.aksamim!.length,
              itemBuilder: (context, index) {
                return widget.aksamim!.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // Konteyner rengi
                          borderRadius:
                              BorderRadius.circular(10), // Köşe yarıçapı
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.grey.withOpacity(0.095), // Gölge rengi
                              spreadRadius: 5, // Yayılma yarıçapı
                              blurRadius: 7, // Bulanıklık yarıçapı
                              offset: const Offset(0, 3), // Gölgenin konumu
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Bu tarihte Akşam öğün verisi Bulunmamaktadır.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    : FoodsItem(food: widget.aksamim![index]);
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
  }
}
