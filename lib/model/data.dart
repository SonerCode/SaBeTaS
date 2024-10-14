class DataModel {
  final int alinankalori;
  final int gereklikalori;

  DataModel({
    required this.alinankalori,
    required this.gereklikalori,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        alinankalori: json['alinankalori'] ,
        gereklikalori: json['gereklikalori'] ,
      );

  Map<String, dynamic> toJson() => {
        'alinankalori': alinankalori,
        'gereklikalori': gereklikalori,
      };
}
