import 'package:equatable/equatable.dart';

class ResponseModel extends Equatable {
  final int statusCode; // Explicitly defining type as int
  final dynamic data; // Use dynamic for flexible data types

  const ResponseModel({required this.statusCode, required this.data});

  @override
  List<Object?> get props => [statusCode, data];
}
