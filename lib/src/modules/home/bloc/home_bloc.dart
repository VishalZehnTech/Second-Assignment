import 'package:assignment_second/src/modules/home/model/Home_model.dart';
import 'package:assignment_second/src/services/db_Service.dart';
import 'package:assignment_second/src/services/db_service_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Database service to interact with the API.
  final DbService dbService;

  // Constructor initializes the Bloc with the database service and the initial state.
  HomeBloc(this.dbService) : super(const HomeState()) {
    on<FetchUserList>(
        _onFetchUserList); // Register event handler for fetching user list.
  }

  // Event handler for FetchUserList.
  // Fetches the user list from the API and emits corresponding states.
  Future<void> _onFetchUserList(
      FetchUserList event, Emitter<HomeState> emit) async {
    emit(UserListLoading()); // Emit loading state.
    try {
      // Call the API using dbService to get the user list.
      ResponseModel responseModel = await dbService.getApi("users");

      // Convert the API response to HomeModel.
      HomeModel homeModel = HomeModel.fromJson(responseModel.data);

      // Emit the loaded state with the user list.
      emit(UserListLoaded(homeModel));
    } catch (e) {
      // Emit an error state if the API call fails.
      emit(UserListError(message: e.toString()));
    }
  }
}
