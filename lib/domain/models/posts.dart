class PostsResponse {
  List<PostsModel> data;
  PostsResponse({
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data.map((x) => x.toJson()).toList(),
    };
  }

  factory PostsResponse.fromJson(Map<String, dynamic> json) {
    return PostsResponse(
      data: List<PostsModel>.from(
        (json['data'] as List<int>).map<PostsModel>(
          (x) => PostsModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class PostsModel {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  PostsModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
  Map<String, dynamic> toJson() {
    var data = {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body,
    };

    return data;
  }

  @override
  bool operator ==(covariant PostsModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
  }
}
