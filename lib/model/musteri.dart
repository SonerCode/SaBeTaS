class MusteriModel {
  final String diyetisyenuid;
  final String password;
  final String name;
  final String surname;
  final String email;
  final String resim;
  final String uid;
  final int kilo;
  final int boy;
  final DateTime dogumtarih;

  const MusteriModel({
    required this.diyetisyenuid,
    required this.name,
    required this.password,
    required this.surname,
    required this.resim,
    required this.kilo,
    required this.boy,
    required this.email,
    required this.uid,
    required this.dogumtarih,
  });

  factory MusteriModel.fromJson(Map<String, dynamic> json) => MusteriModel(
        diyetisyenuid: json['diyetisyenuid'],
        name: json['name'],
        dogumtarih: json['dogumtarih'] != null
            ? json['dogumtarih'].toDate()
            : DateTime.now(),
        password: json['password'],
        surname: json['surname'],
        resim: json['resim'],
        email: json['email'],
        uid: json['uid'],
        boy: json['boy'],
        kilo: json['kilo'],
      );
  Map<String, dynamic> toJson() => {
        'diyetisyenuid': diyetisyenuid,
        'name': name,
        'password': password,
        'surname': surname,
        'resim': resim,
        'email': email,
        'boy': boy,
        'kilo': kilo,
        'uid': uid,
        'dogumtarih': dogumtarih,
      };
}
