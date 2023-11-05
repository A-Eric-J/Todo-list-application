
/// [User] model is for users who has account in this app
class User {
  String? id;
  String? fullName;
  String? email;
  String? image;

  User({this.id, this.fullName, this.email,this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    fullName = json['fullName'] ?? '';
    email = json['email'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['image'] = email;
    return data;
  }
}
