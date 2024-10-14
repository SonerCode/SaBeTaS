import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/firebase_provider.dart';
import 'widget/musteritem.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<FirebaseProvider>(context, listen: false).getmusteriler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text("Mesajlar"),
      ),
      body: Consumer<FirebaseProvider>(builder: (context, value, child) {
        return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: value.musteriler.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 15);
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                MusteriItem(musteri: value.musteriler[index]));
      }),
    );
  }
}
