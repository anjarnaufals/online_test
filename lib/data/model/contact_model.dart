import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  const ContactModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? dob;

  factory ContactModel.fromMap(Map<String, Object?> data) => ContactModel(
        id: data['id'] as String?,
        firstName: data['firstName'] as String?,
        lastName: data['lastName'] as String?,
        email: data['email'] as String?,
        dob: data['dob'] as String?,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'dob': dob,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ContactModel].
  factory ContactModel.fromJson(String data) {
    return ContactModel.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [ContactModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ContactModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? dob,
  }) {
    return ContactModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, firstName, lastName, email, dob];
}
