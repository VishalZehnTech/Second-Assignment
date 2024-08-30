part of 'verber_bloc.dart';

abstract class VerberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsers extends VerberEvent {
  // final List<Datum> newUserList;
  // FetchUsers({required this.newUserList});

  // @override
  // List<Object?> get props => [newUserList];
}
