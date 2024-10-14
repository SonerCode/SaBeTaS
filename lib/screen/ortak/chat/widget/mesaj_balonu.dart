import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../model/mesaj.dart';

class MesajBalonu extends StatelessWidget {
  const MesajBalonu({super.key, required this.mesaj, required this.isMe});
  final Message mesaj;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isMe ? Colors.green : const Color.fromARGB(255, 6, 94, 167),
          borderRadius: isMe
              ? const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
        ),
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Text(mesaj.mesaj, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 5),
            Text(
              timeago.format(mesaj.tarih),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
