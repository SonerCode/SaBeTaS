import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebase_provider.dart';
import '../../diyetisyen/chat/widget/dchat_textfiles.dart';
import 'mchat_messages.dart';

class MChatScreen extends StatefulWidget {
  const MChatScreen({super.key, required this.diyetisyenuid});
  final String diyetisyenuid;

  @override
  State<MChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getMesajlarM(widget.diyetisyenuid)
      ..getMusteriByDiyetisyenId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MChatMessages(alanid: widget.diyetisyenuid),
            ChatTexfield(
              alanid: widget.diyetisyenuid,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        title: Consumer<FirebaseProvider>(builder: (context, value, child) {
          return value.diyetisyen != null
              ? Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        148, 134, 241, 175), // Konteyner rengi
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
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(value.diyetisyen!.resim),
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            value.diyetisyen!.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : const Text(
                  "",
                  style: TextStyle(color: Colors.amber),
                );
        }));
  }
}
