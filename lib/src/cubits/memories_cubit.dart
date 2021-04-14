import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memories_app/src/models/memories_response.dart';
import 'package:memories_app/src/resources/repositories/memories_repository.dart';

part 'memories_state.dart';

class MemoriesCubit extends Cubit<MemoriesState> {
  final MemoriesRepository _memoriesRepository;

  MemoriesCubit(this._memoriesRepository) : super(MemoriesInitial());

  Future<void> getMemoriesAround(double latitude, double longitude) async {
    try {
      emit(MemoriesLoading());
      final memoriesResponse = await _memoriesRepository.fetchMemoriesAround(
          latitude: latitude.toString(), longitude: longitude.toString());
      emit(MemoriesLoaded(memoriesResponse));
    } on NetworkException {
      emit(MemoriesError("Couldn't fetch memories. Is the device online?"));
    }
  }
}
