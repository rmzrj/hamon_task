class Subjects {
  Subjects({
      int credits, 
      int id, 
      String name, 
      String teacher,}){
    _credits = credits;
    _id = id;
    _name = name;
    _teacher = teacher;
}

  Subjects.fromJson(dynamic json) {
    _credits = json['credits'];
    _id = json['id'];
    _name = json['name'];
    _teacher = json['teacher'];
  }
  int _credits;
  int _id;
  String _name;
  String _teacher;

  int get credits => _credits;
  int get id => _id;
  String get name => _name;
  String get teacher => _teacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['credits'] = _credits;
    map['id'] = _id;
    map['name'] = _name;
    map['teacher'] = _teacher;
    return map;
  }

}