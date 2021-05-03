part of 'memories_cubit.dart';

abstract class MemoriesState extends Equatable {
  const MemoriesState();
}

class MemoriesInitial extends MemoriesState {
  const MemoriesInitial();

  @override
  List<Object> get props => [];
}

class MemoriesLoading extends MemoriesState {
  const MemoriesLoading();

  @override
  List<Object> get props => [];
}

class MemoriesLoaded extends MemoriesState {
  final MemoriesResponse memoriesResponse;

  const MemoriesLoaded(this.memoriesResponse);

  @override
  List<Object> get props => [memoriesResponse];
}

class MemoriesError extends MemoriesState {
  const MemoriesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
