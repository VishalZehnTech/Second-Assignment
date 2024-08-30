// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  final statusCode;
  final data;

  const ResponseModel({this.statusCode, this.data});

  @override
  List<Object?> get props => [statusCode, data];
}
