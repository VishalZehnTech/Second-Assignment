import 'package:assignment_second/src/modules/verbersuggesties/bloc/verber_state.dart';
import 'package:assignment_second/src/modules/verbersuggesties/model/verber_model.dart';
import 'package:assignment_second/src/services/db_Service.dart';
import 'package:assignment_second/src/services/db_service_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verber_event.dart';

// Bloc for managing state related to fetching and displaying users
class VerberBloc extends Bloc<VerberEvent, VerberState> {
  // Flag to ensure data is loaded only once
  bool dataLoadOnce = true;

  // Service for interacting with the database or API
  final DbService dbService;

  // Page number for pagination
  int page = 1;

  // Constructor initializes the bloc with the DbService and sets the initial state
  VerberBloc(this.dbService) : super(const VerberState()) {
    // Handler for the FetchUsers event
    on<FetchUsers>(_onFetchVerbers);
  }

  // Method to handle the FetchUsers event
  Future<void> _onFetchVerbers(
      FetchUsers event, Emitter<VerberState> emit) async {
    // If data has not been loaded once, emit loading state
    if (dataLoadOnce) {
      dataLoadOnce = false;
      emit(VerberLoading());
    }
    try {
      // Fetch data from the API
      ResponseModel responseModel = await dbService.getApi("users?page=$page");
      // Parse the response data into a VerberModel
      VerberModel verberModel = VerberModel.fromJson(responseModel.data);

      // Check if the last page is reached
      if (verberModel.totalPages == page) {
        // Reset the flag and emit loaded state with no more data
        dataLoadOnce = true;
        emit(VerberLoaded(newUserList: verberModel.data, isMoreData: false));
      } else {
        // Increment page number and emit loaded state with more data
        page++;
        emit(VerberLoaded(newUserList: verberModel.data, isMoreData: true));
      }
    } catch (e) {
      // Print error to debug console and emit error state
      debugPrint("$e");
      emit(VerberError(e.toString()));
    }
  }
}
