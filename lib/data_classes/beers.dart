class Beer {
  final int id;
  final String name;
  final String tagline;
  final String firstBrewed;
  final String description;
  final String image;

  const Beer({
    required this.id,
    required this.name,
    required this.tagline,
    required this.firstBrewed,
    required this.description,
    required this.image,
  });

  // Factory constructor to create a Beer from JSON
  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      firstBrewed: json['first_brewed'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  // Method to convert Beer to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'first_brewed': firstBrewed,
      'description': description,
      'image': image,
    };
  }

  // Override toString for better debugging
  @override
  String toString() {
    return 'Beer(id: $id, name: $name, tagline: $tagline, firstBrewed: $firstBrewed, description: $description, image: $image)';
  }

  // Override equality operators
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Beer && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // CopyWith method for creating modified copies
  Beer copyWith({
    int? id,
    String? name,
    String? tagline,
    String? firstBrewed,
    String? description,
    String? image,
  }) {
    return Beer(
      id: id ?? this.id,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      firstBrewed: firstBrewed ?? this.firstBrewed,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
