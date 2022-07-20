import 'dart:convert';

List<Comment> commentFromJson(dynamic str) =>
    List<Comment>.from(str.map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  String postId;
  int id;
  String name;
  String email;
  String body;

  Comment copyWith({
    String? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) =>
      Comment(
        postId: postId ?? this.postId,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        postId: json["postId"].toString(),
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
