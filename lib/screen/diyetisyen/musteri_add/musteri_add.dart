import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../provider/firebaseauth_service.dart';

class MusteriAdd extends StatefulWidget {
  const MusteriAdd({super.key});

  @override
  State<MusteriAdd> createState() => _MusteriAddState();
}

class _MusteriAddState extends State<MusteriAdd> {
  final List<String> avatarUrls = [
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334225.jpg?alt=media&token=e7f8ef3f-5b92-49f4-b906-8cab6258febb',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334234.jpg?alt=media&token=b34601cc-ab0f-43d9-9a95-32407d2b62a3',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334237.jpg?alt=media&token=ac3d4813-1929-4a20-9c98-8da7a161210e',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334240.jpg?alt=media&token=e30d06a5-c9be-44ca-abe9-48092fae6874',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334243.jpg?alt=media&token=65b53c0a-a068-487c-a069-dac62cc70e32',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334244.jpg?alt=media&token=e91f129c-c253-40aa-ad62-76399af8c5b9',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334389.jpg?alt=media&token=43d435c3-8467-40fb-920e-1b48932fc60e',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334398.jpg?alt=media&token=e3895f65-6c75-4a8f-94c0-8208b9ee8c9f',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9334415.jpg?alt=media&token=7afc7d5f-c873-4f2b-a887-8221b1ed0225',
    'https://firebasestorage.googleapis.com/v0/b/wise-chalice-407518.appspot.com/o/Profile_Pictures%2F9434619.jpg?alt=media&token=807a453e-25fc-4fc4-a648-dada0dd17ee8',
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Kullanıcının seçtiği resmi saklayacak değişken
  String selectedAvatarUrl = '';

  @override
  void initState() {
    // İlk resmi varsayılan olarak seçiyoruz
    selectedAvatarUrl = avatarUrls.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Müşteri Ekle'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ad',
                  ),
                ),
                TextField(
                  controller: _surnameController,
                  decoration: const InputDecoration(labelText: 'Soyad'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Şifre'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Resim seçme butonu
                ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Resim Seç',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                ),
                                itemCount: avatarUrls.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedAvatarUrl = avatarUrls[index];
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Image.network(avatarUrls[index]),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Resim Seç'),
                ),

                // Seçilen resmi gösteren widget
                Image.network(
                  selectedAvatarUrl,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String name = _nameController.text;
                    String surname = _surnameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    FirebaseGiris().musteriSignup(
                      context: context,
                      name: name,
                      surname: surname,
                      email: email,
                      password: password,
                      diyetisyenuid: FirebaseAuth.instance.currentUser!.uid,
                      resim: selectedAvatarUrl, // Seçilen resim URL'si
                    );
                  },
                  child: const Text('Kaydet'),
                ),
              ],
            ),
          ),
        ));
  }
}
