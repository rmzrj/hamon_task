class Registermodel {
  Registermodel({
    List<Registrations> registrations,
  }) {
    _registrations = registrations;
  }

  Registermodel.fromJson(dynamic json) {
    if (json['registrations'] != null) {
      _registrations = [];
      json['registrations'].forEach((v) {
        _registrations?.add(Registrations.fromJson(v));
      });
    }
  }
  List<Registrations> _registrations;

  List<Registrations> get registrations => _registrations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_registrations != null) {
      map['registrations'] = _registrations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Registrations {
  Registrations({
    int id,
    int student,
    int subject,
  }) {
    _id = id;
    _student = student;
    _subject = subject;
  }

  Registrations.fromJson(dynamic json) {
    _id = json['id'];
    _student = json['student'];
    _subject = json['subject'];
  }
  int _id;
  int _student;
  int _subject;

  int get id => _id;
  int get student => _student;
  int get subject => _subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['student'] = _student;
    map['subject'] = _subject;
    return map;
  }
}
