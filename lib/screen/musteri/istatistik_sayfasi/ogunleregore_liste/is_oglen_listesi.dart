import 'package:flutter/material.dart';

import '../../../../model/food.dart';
import '../FoodsItem.dart';

// ignore: must_be_immutable
class IsOglen extends StatefulWidget {
  IsOglen({super.key, required this.oglenim});
  List<FoodModel>? oglenim;
  @override
  State<IsOglen> createState() => _IsOglenState();
}

class _IsOglenState extends State<IsOglen> {
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
                'ÖĞLEN',
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
            height: widget.oglenim!.isEmpty
                ? 1 * 50000 / heig
                : widget.oglenim!.length * 60000 / heig,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount: widget.oglenim!.isEmpty ? 1 : widget.oglenim!.length,
              itemBuilder: (context, index) {
                return widget.oglenim!.isEmpty
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
                            'Bu tarihte Öğlen yemek verisi Bulunmamaktadır.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    : FoodsItem(food: widget.oglenim![index]);
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
