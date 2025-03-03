class Folder {
  final String id;
  final String name;
  final int sortIndex;

  Folder({required this.id, required this.name, required this.sortIndex});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sortIndex': sortIndex,
    };
  }

  static Folder fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      name: map['name'],
      sortIndex: map['sortIndex'] ?? 0,
    );
  }

  Folder copyWith({String? id, String? name, int? sortIndex}) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      sortIndex: sortIndex ?? this.sortIndex,
    );
  }
}
