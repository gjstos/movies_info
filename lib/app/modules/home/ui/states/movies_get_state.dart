import '../../domain/errors/errors.dart';

abstract class GetMoviesState {}

class StartState implements GetMoviesState {
  const StartState();
}

class LoadingState implements GetMoviesState {
  const LoadingState();
}

class ErrorState implements GetMoviesState {
  final Failure error;
  const ErrorState(this.error);
}

class NoInternetConnectionState implements GetMoviesState {
  const NoInternetConnectionState();
}

class SuccessState implements GetMoviesState {
  const SuccessState();
}
