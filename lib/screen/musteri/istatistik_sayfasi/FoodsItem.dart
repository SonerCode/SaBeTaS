// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../model/food.dart';

class FoodsItem extends StatefulWidget {
  const FoodsItem({super.key, required this.food});
  final FoodModel food;

  @override
  State<FoodsItem> createState() => _FoodsItemState();
}

class _FoodsItemState extends State<FoodsItem> {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Colors.white, // Konteyner rengi
          borderRadius: BorderRadius.circular(10), // Köşe yarıçapı
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.095), // Gölge rengi
              spreadRadius: 5, // Yayılma yarıçapı
              blurRadius: 7, // Bulanıklık yarıçapı
              offset: const Offset(0, 3), // Gölgenin konumu
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.food.resim),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.food.fkalori} kcal',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
