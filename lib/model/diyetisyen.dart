class DiyetisyenModel {
  final String name;
  final String surname;
  final String email;
  final String resim;
  final String uid;
  final String password;

  const DiyetisyenModel({
    required this.name,
    required this.password,
    required this.surname,
    required this.resim,
    required this.email,
    required this.uid,
  });

  factory DiyetisyenModel.fromJson(Map<String, dynamic> json) =>
      DiyetisyenModel(
        name: json['name'],
        password: json['password'],
        surname: json['surname'],
        resim: json['resim'],
        email: json['email'],
        uid: json['uid'],
      );
  Map<String, dynamic> toJson() => {
        'name': name,
        'password': password,
        'surname': surname,
        'resim': resim,
        'email': email,
        'uid': uid,
      };
}
