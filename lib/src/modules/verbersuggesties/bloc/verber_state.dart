import 'package:assignment_second/src/modules/verbersuggesties/model/verber_model.dart';
import 'package:equatable/equatable.dart';

class VerberState extends Equatable {
  const VerberState();

  @override
  List<Object?> get props => [];
}

class VerberInitial extends VerberState {}

class VerberLoading extends VerberState {}

class VerberLoaded extends VerberState {
  // final VerberModel verberModel;
  final List<Datum> newUserList;
  final bool isMoreData;

  const VerberLoaded({
    // required this.verberModel,
    required this.newUserList,
    this.isMoreData = false,
  });

  VerberLoaded copyWith({
    List<Datum>? newUserList,
    bool? isMoreData,
  }) {
    return VerberLoaded(
      newUserList: newUserList ?? this.newUserList,
      isMoreData: isMoreData ?? this.isMoreData,
    );
  }

  @override
  List<Object> get props => [newUserList, isMoreData];
}

class VerberError extends VerberState {
  final String message;
  const VerberError(this.message);

  @override
  List<Object?> get props => [message];
}
