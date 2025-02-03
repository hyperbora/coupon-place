class Folder {
  final String id;
  final String name;

  Folder({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Folder fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      name: map['name'],
    );
  }
}
