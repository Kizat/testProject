import 'dart:convert';

List<Album> albumFromJson(dynamic str) =>
    List<Album>.from(str.map((x) => Album.fromJson(x)));

String albumToJson(List<Album> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  int userId;
  int id;
  String title;

  Album copyWith({
    int? userId,
    int? id,
    String? title,
  }) =>
      Album(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
