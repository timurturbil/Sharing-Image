class BlogModel {
  String description;
  String imageUrl;
  String title;
  String key;

  BlogModel({this.description, this.imageUrl, this.title});

  BlogModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    imageUrl = json['imageUrl'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    return data;
  }
}