class Coupon {
  final String title;
  final String description;
  final DateTime expiryDate;

  Coupon(
      {required this.title,
      required this.description,
      required this.expiryDate});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  static Coupon fromMap(Map<String, dynamic> map) {
    return Coupon(
      title: map['title'],
      description: map['description'],
      expiryDate: DateTime.parse(map['expiryDate']),
    );
  }
}
