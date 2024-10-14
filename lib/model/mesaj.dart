class Message {
  final String gonderen;
  final String alan;
  final String mesaj;
  final DateTime tarih;
  

  const Message({
    required this.gonderen,
    required this.alan,
    required this.tarih,
    required this.mesaj,
    
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(
        alan: json['alan'],
        gonderen: json['gonderen'],
        tarih: json['tarih'].toDate(),
        mesaj: json['mesaj'],
        
      );



  Map<String, dynamic> toJson() => {
        'alan': alan,
        'gonderen': gonderen,
        'tarih': tarih,
        'mesaj': mesaj,
      };

 
}

