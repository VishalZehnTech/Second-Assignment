part of 'home_bloc.dart';

// It extends Equatable to support value comparison.
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => []; // Props for Equatable to compare objects.
}

// Event class to trigger fetching the user list.
// It doesn't require any additional properties, so props are empty.
class FetchUserList extends HomeEvent {
  @override
  List<Object> get props => []; // No additional properties to compare.
}
