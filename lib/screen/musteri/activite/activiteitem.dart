import 'package:flutter/material.dart';

import '../../../model/food.dart';
import '../../../provider/firebasefoods.dart';
import '../../homescreen/navigation_bar.dart';

class ActiviteItem extends StatefulWidget {
  const ActiviteItem({super.key, required this.food, required this.ogun});
  final FoodModel food;
  final String ogun;

  @override
  State<ActiviteItem> createState() => _FoodItemState();
}

class _FoodItemState extends State<ActiviteItem> {
  int _yapilandk = 10; // Default value for ate grams

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.food.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Kalori: ${widget.food.fkalori}'),
              const SizedBox(height: 10),
              const Text('Kaç dakika bu aktiviteyi yaptınız?'),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _yapilandk = int.tryParse(value) ?? 10;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                FoodModel yenifood = widget.food.copyWith(
                    fkalori: (widget.food.fkalori * _yapilandk ~/ 10).toInt());
                await FireFood.activiteklebana(
                    food: yenifood, ogun: widget.ogun);
                Navigator.pushReplacement(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (_) => const MNavigationBarim()),
                );
              },
              child: const Text('Tamam'),
            ),
            TextButton(
              onPressed: () {
                // Handle "İptal" button tap
                Navigator.of(context).pop();
              },
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );
  }

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
          onTap: () async {
            _showDialog(context);
          },
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.food.fkalori} kcal',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '   10 dk',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
