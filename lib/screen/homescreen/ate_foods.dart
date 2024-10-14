import 'package:flutter/material.dart';

import '../../model/food.dart';
import '../../provider/firebasefoods.dart';

class AteFoodsItem extends StatefulWidget {
  const AteFoodsItem({super.key, required this.food, required this.ogun});
  final String ogun;
  final FoodModel food;

  @override
  State<AteFoodsItem> createState() => _AteFoodsState();
}

class _AteFoodsState extends State<AteFoodsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        onTap: () {},
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
            const Padding(padding: EdgeInsets.all(35)),
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
        trailing: IconButton(
            onPressed: () {
              FireFood.foodsilbenden(ogun: widget.ogun, food: widget.food);
            },
            icon: const Icon(Icons.restore_from_trash_rounded)),
      ),
    );
  }
}
