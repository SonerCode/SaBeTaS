import 'package:flutter/material.dart';

import '../../../../model/food.dart';
import '../FoodsItem.dart';

// ignore: must_be_immutable
class IsActivite extends StatefulWidget {
  IsActivite({super.key, required this.activitem});
  List<FoodModel>? activitem;

  @override
  State<IsActivite> createState() => _IsActiviteState();
}

class _IsActiviteState extends State<IsActivite> {
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
                'AKTİVİTE',
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
            height: widget.activitem!.isEmpty
                ? 1 * 50000 / heig
                : widget.activitem!.length * 60000 / heig,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount:
                  widget.activitem!.isEmpty ? 1 : widget.activitem!.length,
              itemBuilder: (context, index) {
                return widget.activitem!.isEmpty
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
                            'Bu tarihte Aktivite verisi Bulunmamaktadır.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    : FoodsItem(food: widget.activitem![index]);
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
