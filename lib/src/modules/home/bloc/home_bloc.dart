import 'package:assignment_second/src/modules/home/model/Home_model.dart';
import 'package:assignment_second/src/services/db_Service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DbService dbService;

  HomeBloc(this.dbService) : super(const HomeState()) {
    on<FetchUserList>(_onFetchUserList);
  }

  Future<void> _onFetchUserList(
      FetchUserList event, Emitter<HomeState> emit) async {
    emit(UserListLoading());
    try {
      final userList = await dbService.fetchUsers("users");
      emit(UserListLoaded(userList));
    } catch (e) {
      emit(UserListError(message: e.toString()));
    }
  }
}
