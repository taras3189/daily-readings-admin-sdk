class Permissions {
  late final int? id;
  late final String? permName;
  late final String? permDescription;
  late final String? createdAt;
  late final String? updatedAt;

  Permissions(
      {this.id,
      this.permName,
      this.permDescription,
      this.createdAt,
      this.updatedAt});

  factory Permissions.fromJson(Map<String, dynamic> json) {
    return Permissions(
      id: json['id'] as int,
      permName: json['perm_name'] as String,
      permDescription: json['perm_description'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  @override
  String toString() {
    return '$permDescription';
  }
}

