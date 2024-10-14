import 'package:flutter/material.dart';

import '../../../../model/food.dart';
import '../FoodsItem.dart';

// ignore: must_be_immutable
class IsKahvalti extends StatefulWidget {
  IsKahvalti({super.key, required this.kahvaltim});
  List<FoodModel>? kahvaltim;

  @override
  State<IsKahvalti> createState() => _IsKahvaltiState();
}

class _IsKahvaltiState extends State<IsKahvalti> {
  final List<FoodModel> foodData = [
    const FoodModel(
      fooduid: '1',
      name: 'Elma',
      fkalori: 52,
      resim: 'https://www.verita.com.tr/wp-content/uploads/2014/08/elma.jpg',
    ),
    const FoodModel(
      fooduid: '2',
      name: 'Muz',
      fkalori: 89,
      resim: 'https://www.verita.com.tr/wp-content/uploads/2014/08/muz.jpg',
    ),
    const FoodModel(
      fooduid: '3',
      name: 'Armut',
      fkalori: 47,
      resim: 'https://www.verita.com.tr/wp-content/uploads/2014/08/armut.jpg',
    ),
    const FoodModel(
      fooduid: '4',
      name: 'Kavun',
      fkalori: 33,
      resim: 'https://www.verita.com.tr/wp-content/uploads/2014/08/kavun.jpg',
    ),
    const FoodModel(
      fooduid: '5',
      name: 'Üzüm',
      fkalori: 69,
      resim: 'https://www.verita.com.tr/wp-content/uploads/2014/08/uzum1.jpg',
    ),
  ];
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
                'KAHVALTI',
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
            height: widget.kahvaltim!.isEmpty
                ? 1 * 50000 / heig
                : widget.kahvaltim!.length * 60000 / heig,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: ListView.separated(
              itemCount:
                  widget.kahvaltim!.isEmpty ? 1 : widget.kahvaltim!.length,
              itemBuilder: (context, index) {
                return widget.kahvaltim!.isEmpty
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
                            'Bu tarihte Aksam yemek verisi Bulunmamaktadır.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ))
                    : FoodsItem(food: widget.kahvaltim![index]);
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
