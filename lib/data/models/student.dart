// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  String name;
  String msv;
  String dateOfBirth;
  String course;
  String majors;
  Student({
    required this.name,
    required this.msv,
    required this.dateOfBirth,
    required this.course,
    required this.majors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'msv': msv,
      'dateOfBirth': dateOfBirth,
      'course': course,
      'majors': majors,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] as String,
      msv: map['msv'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      course: map['course'] as String,
      majors: map['majors'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  
}
