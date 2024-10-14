class FoodModel {
  final String fooduid;
  final String name;
  final int fkalori;
  final String resim;

  const FoodModel({
    required this.fooduid,
    required this.name,
    required this.fkalori,
    required this.resim,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        name: json['name'],
        fooduid: json['fooduid'],
        fkalori: json['fkalori'],
        resim: json['resim'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'resim': resim,
        'fkalori': fkalori,
        'fooduid': fooduid,
      };

  FoodModel copyWith({
    String? fooduid,
    String? name,
    int? fkalori,
    String? resim,
  }) {
    return FoodModel(
      fooduid: fooduid ?? this.fooduid,
      name: name ?? this.name,
      fkalori: fkalori ?? this.fkalori,
      resim: resim ?? this.resim,
    );
  }
}
