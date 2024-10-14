import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/firebase_service.dart';
import '../../homescreen/navigation_bar.dart'; // Tarih biçimlendirme için

// ignore: must_be_immutable
class MBilgiG extends StatefulWidget {
  MBilgiG({super.key, required this.diyetisyen});
  String diyetisyen;

  @override
  State<MBilgiG> createState() => _MBilgiGState();
}

class _MBilgiGState extends State<MBilgiG> {
  late int _boy;
  late int _kilo;
  late DateTime _dogumtarihi = DateTime.now();

  String? _boyError;
  String? _kiloError;
  void _ilkgiris() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLogin = prefs.getBool('first_login') ?? true;

    if (isFirstLogin) {
      if (mounted) {
        setState(() {
          prefs.setBool('first_login', false);
        });
      }
    } else {
      if (mounted) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MNavigationBarim()),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _ilkgiris();

    _boy = 0;
    _kilo = 0;
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dogumtarihi,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _dogumtarihi) {
      setState(() {
        _dogumtarihi = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Ekranın ortasına yerleştirmek için Center widget'ını kullanın
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text('Boy (cm)'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _boy = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  errorText: _boyError,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Kilo (kg)'),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _kilo = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  errorText: _kiloError,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Doğum Tarihi: ${DateFormat('y-MM-dd').format(_dogumtarihi)}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _showDatePicker(context),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _boyError = _boy == 0 ? 'Boyunuzu girin' : null;
                    _kiloError = _kilo == 0 ? 'Kilonuzu girin' : null;
                  });

                  if (_boy == 0 || _kilo == 0) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Eksik Bilgi'),
                          content: const Text(
                              'Lütfen boy ve kilo bilgilerinizi girin.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Tamam'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    FirebaseUpdate.updateMusteri(
                        boy: _boy,
                        kilo: _kilo,
                        dogumtarih: _dogumtarihi,
                        diyetisyenuid: widget.diyetisyen);

                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MNavigationBarim()),
                    );
                  }
                },
                child: const Text('Kayıt Ol'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
