class Tab1MainModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  Tab1MainModel({this.id, this.userId, this.title, this.body});

  factory Tab1MainModel.fromJson(Map<String, dynamic> json) {
    return Tab1MainModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}
