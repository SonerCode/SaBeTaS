import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/musteri.dart';
import '../../../../provider/firebase_diyetisyen_provider.dart';

class MusteriSil extends StatefulWidget {
  const MusteriSil({super.key});

  @override
  State<MusteriSil> createState() => _MusteriSilState();
}

class _MusteriSilState extends State<MusteriSil> {
  @override
  void initState() {
    super.initState();
    Provider.of<FireDiyetisyen>(context, listen: false).getmusterilerim();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FireDiyetisyen>(
      builder: (context, value, child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Müşteri Silme Ekranı'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_outlined),
              ),
            ),
            // ignore: unnecessary_null_comparison
            body: value.musteriler != null
                ? ListView.separated(
                    itemCount: value.musteriler.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 5);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final MusteriModel musterim = value.musteriler[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.45),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(musterim.resim),
                          ),
                          title: Text(
                            '${musterim.name} ${musterim.surname}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            musterim.email,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Silme işlemi için onay iletişim kutusu gösterme
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Diyetisyeni Sil'),
                                    content: Text(
                                        '${value.musteriler[index].name} isimli diyetisyeni silmek istediğinizden emin misiniz?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Hayır'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            FireDiyetisyen.musterisil(
                                                musteriuid: value
                                                    .musteriler[index].uid);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Tamam'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
                : const BosMusteri());
      },
    );
  }
}

class BosMusteri extends StatelessWidget {
  const BosMusteri({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white54, // Konteyner rengi
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Gösterilecek diyetisyen bulunmamaktadır!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              )),
              Icon(
                Icons.cancel_presentation_rounded,
                size: 135,
              )
            ],
          )),
    ));
  }
}
