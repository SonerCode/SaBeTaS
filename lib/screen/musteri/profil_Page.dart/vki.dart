import 'package:flutter/material.dart';

import '../../../service/firebase_service.dart';
import 'hesap_screen.dart';

// ignore: must_be_immutable
class VkiGuncelle extends StatefulWidget {
  VkiGuncelle(
      {super.key, required this.diyetisyen, required this.musteriresim});
  String diyetisyen;
  String musteriresim;

  @override
  // ignore: library_private_types_in_public_api
  _VkiGuncelleState createState() => _VkiGuncelleState();
}

class _VkiGuncelleState extends State<VkiGuncelle> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;

  double _calculateBMI(int weight, int height) {
    double heightInMeters = height / 100;
    return double.parse(
        (weight / (heightInMeters * heightInMeters)).toStringAsFixed(2));
  }

  void _updateBMI() {
    final int? weight = int.tryParse(_weightController.text);
    final int? height = int.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      setState(() {
        _bmi = _calculateBMI(weight, height);
      });
    } else {
      setState(() {
        _bmi = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Text('Vücut Kitle Endeksi'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _updateBMI;
                int? weig = 0;
                int? heig = 0;
                weig = int.tryParse(_weightController.text);
                heig = int.tryParse(_heightController.text);
                FirebaseUpdate.updateMusteriVki(
                    boy: heig!, kilo: weig!, diyetisyenuid: widget.diyetisyen);
                if (_bmi != null) {
                  Navigator.pushReplacement(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                        builder: (_) => HesapEkrani(
                              diyetisyen: widget.diyetisyen,
                              resim: widget.musteriresim,
                            )),
                  );
                }
              },
              child: const Text('Vki Hesapla'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ));
  }
}
