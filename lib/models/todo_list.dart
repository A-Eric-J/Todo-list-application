/// [TodoList] model

class TodoList {
  int? id;
  String? text;
  bool? isChecked;

  TodoList({this.id, this.text, this.isChecked});

  TodoList.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    text = json['text'] ?? '';
    isChecked = json['isChecked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['isChecked'] = isChecked;
    return data;
  }
}
