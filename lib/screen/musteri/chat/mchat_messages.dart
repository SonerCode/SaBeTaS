import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebase_provider.dart';
import '../../ortak/chat/widget/empty_widget.dart';
import '../../ortak/chat/widget/mesaj_balonu.dart';

class MChatMessages extends StatefulWidget {
  const MChatMessages({super.key, required this.alanid});
  final String alanid;
  @override
  State<MChatMessages> createState() => _MChatMessagesState();
}

class _MChatMessagesState extends State<MChatMessages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
        builder: (context, value, child) => value.mesajlar.isEmpty
            ? const Expanded(
                child: EmptyWidget(icon: Icons.waving_hand, text: 'Merhaba!'),
              )
            : Expanded(
                child: ListView.builder(
                itemCount: value.mesajlar.length,
                itemBuilder: (BuildContext context, int index) {
                  final bool isMe =
                      widget.alanid != value.mesajlar[index].gonderen;
                  return MesajBalonu(
                    mesaj: value.mesajlar[index],
                    isMe: isMe,
                  );
                },
              )));
  }
}
