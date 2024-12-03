class Filter {
  final String name;
  final String imageLink;
  final int count;

  Filter({
    required this.name,
    required this.imageLink,
    required this.count,
  });

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      name: json['name'],
      imageLink: json['imageLink'],
      count: json['count'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final otherFilter = other as Filter;
    return name == otherFilter.name &&
        imageLink == otherFilter.imageLink &&
        count == otherFilter.count;
  }

  @override
  int get hashCode => Object.hash(name, imageLink, count);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageLink': imageLink,
      'count': count,
    };
  }
}
