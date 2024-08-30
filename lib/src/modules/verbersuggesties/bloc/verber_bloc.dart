import 'package:assignment_second/src/modules/verbersuggesties/bloc/verber_state.dart';
import 'package:assignment_second/src/modules/verbersuggesties/model/verber_model.dart';
import 'package:assignment_second/src/services/db_Service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verber_event.dart';

class VerberBloc extends Bloc<VerberEvent, VerberState> {
  final DbService dbService;
  int page = 1;
  List<Datum> currentUserList = [];

  VerberBloc(this.dbService) : super(const VerberState()) {
    on<FetchUsers>(_onFetchVerbers);
  }

  Future<void> _onFetchVerbers(
      FetchUsers event, Emitter<VerberState> emit) async {
    emit(VerberLoading());
    try {
      final verberModel = await dbService.fetchUsersList("users?page=$page");
      currentUserList.addAll(verberModel.data);

      // if (verberModel.data.isEmpty) {
      if (verberModel.totalPages == page) {
        emit(VerberLoaded(newUserList: currentUserList, isMoreData: false));
      } else {
        page++;
        emit(VerberLoaded(newUserList: currentUserList, isMoreData: true));
      }
    } catch (e) {
      emit(VerberError(e.toString()));
    }
  }
}
