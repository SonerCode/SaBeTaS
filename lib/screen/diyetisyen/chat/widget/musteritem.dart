import 'package:flutter/material.dart';

import '../../../../model/musteri.dart';
import '../dchat_screen.dart';

class MusteriItem extends StatefulWidget {
  const MusteriItem({super.key, required this.musteri});
  final MusteriModel musteri;

  @override
  State<MusteriItem> createState() => _MusteriItemState();
}

class _MusteriItemState extends State<MusteriItem> {
  @override
  Widget build(BuildContext context) => ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatScreen(
                  musteriuid: widget.musteri.uid,
                ))),
        contentPadding: EdgeInsets.zero,
        leading: Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.musteri.resim),
            ),
          ],
        ),
        title: Text(
          widget.musteri.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
