class Post {
  final String id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});


  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['body'] as String,
      );
  }
  Map<String, dynamic> toJson() { return {
        'id': id,
        'title': title,
        'description': description,
      };
  }

}
