part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  // Props for Equatable to compare objects.
  @override
  List<Object> get props => [];
}

// State representing that the user list has been successfully loaded.
class UserListLoaded extends HomeState {
  // The loaded user list data.
  final HomeModel homeModel;

  const UserListLoaded(this.homeModel);

  // Include homeModel in props for comparison.
  @override
  List<Object> get props => [homeModel];
}

// State representing an error occurred while loading the user list.
class UserListError extends HomeState {
  final String message; // Error message describing the failure.

  const UserListError({required this.message});

  @override
  List<Object> get props =>
      [message]; // Include message in props for comparison.
}

// State representing that the user list is currently being loaded.
class UserListLoading extends HomeState {
  @override
  List<Object> get props =>
      []; // No additional properties needed for this state.
}
