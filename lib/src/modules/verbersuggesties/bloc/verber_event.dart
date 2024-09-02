part of 'verber_bloc.dart';

// Base class for all Verber events
abstract class VerberEvent extends Equatable {
  // Default implementation returns an empty list
  @override
  List<Object?> get props => [];
}

// Event to fetch users from the API
class FetchUsers extends VerberEvent {}
