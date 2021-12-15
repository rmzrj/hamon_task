class Students {
  Students({
      int age, 
      String email, 
      int id, 
      String name,}){
    _age = age;
    _email = email;
    _id = id;
    _name = name;
}

  Students.fromJson(dynamic json) {
    _age = json['age'];
    _email = json['email'];
    _id = json['id'];
    _name = json['name'];
  }
  int _age;
  String _email;
  int _id;
  String _name;

  int get age => _age;
  String get email => _email;
  int get id => _id;
  String get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['age'] = _age;
    map['email'] = _email;
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}