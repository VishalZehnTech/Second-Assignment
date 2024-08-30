part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class UserListLoaded extends HomeState {
  final HomeModel homeModel;
  const UserListLoaded(this.homeModel);
}

class UserListError extends HomeState {
  final String message;
  const UserListError({required this.message});
}

class UserListLoading extends HomeState {}
