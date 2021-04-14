part of 'memories_cubit.dart';

abstract class MemoriesState {
  const MemoriesState();
}

class MemoriesInitial extends MemoriesState {
  const MemoriesInitial();
}

class MemoriesLoading extends MemoriesState {
  const MemoriesLoading();
}

class MemoriesLoaded extends MemoriesState {
  final MemoriesResponse memoriesResponse;

  const MemoriesLoaded(this.memoriesResponse);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MemoriesLoaded &&
        other.memoriesResponse == memoriesResponse;
  }

  @override
  int get hashCode => memoriesResponse.hashCode;
}

class MemoriesError extends MemoriesState {
  final String message;

  const MemoriesError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MemoriesError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
