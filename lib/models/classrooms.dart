class Classrooms {
  Classrooms({
      int id, 
      String layout, 
      String name, 
      int size,}){
    _id = id;
    _layout = layout;
    _name = name;
    _size = size;
}

  Classrooms.fromJson(dynamic json) {
    _id = json['id'];
    _layout = json['layout'];
    _name = json['name'];
    _size = json['size'];
  }
  int _id;
  String _layout;
  String _name;
  int _size;

  int get id => _id;
  String get layout => _layout;
  String get name => _name;
  int get size => _size;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['layout'] = _layout;
    map['name'] = _name;
    map['size'] = _size;
    return map;
  }

}