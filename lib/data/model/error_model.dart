import 'dart:convert';

import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String? message;
  const ErrorModel({
    this.message,
  });

  ErrorModel copyWith({
    String? message,
  }) {
    return ErrorModel(
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) =>
      ErrorModel.fromMap(json.decode(source));

  @override
  String toString() => 'ErrorModel(message: $message)';

  @override
  List<Object?> get props => [message];
}
