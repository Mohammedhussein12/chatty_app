class RoomModel {
  final String id;
  final String name;
  final String categoryId;
  final String description;

  RoomModel(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.description});

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        id: json['id'],
        name: json['name'],
        categoryId: json['categoryId'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'description': description
    };
  }
}
