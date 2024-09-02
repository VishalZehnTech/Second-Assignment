import 'package:assignment_second/src/modules/verbersuggesties/model/verber_model.dart';
import 'package:equatable/equatable.dart';

// Base class for Verber states
class VerberState extends Equatable {
  const VerberState();

  @override
  List<Object?> get props => []; // Default implementation returns an empty list
}

// State when Verber data is initially loaded
class VerberInitial extends VerberState {}

// State while Verber data is being fetched
class VerberLoading extends VerberState {}

// State when Verber data has been successfully loaded
class VerberLoaded extends VerberState {
  final List<Data> newUserList; // List of users fetched
  final bool isMoreData; // Flag to indicate if there are more pages to load

  const VerberLoaded({
    required this.newUserList,
    this.isMoreData = false, // Default to false
  });

  // Creates a copy of the current state with optional new values
  VerberLoaded copyWith({
    List<Data>? newUserList,
    bool? isMoreData,
  }) {
    return VerberLoaded(
      newUserList: newUserList ?? this.newUserList,
      isMoreData: isMoreData ?? this.isMoreData,
    );
  }

  // List of properties to compare
  @override
  List<Object> get props => [newUserList, isMoreData];
}

// State when there is an error fetching Verber data
class VerberError extends VerberState {
  final String message; // Error message

  const VerberError(this.message);

  // List of properties to compare
  @override
  List<Object?> get props => [message];
}
