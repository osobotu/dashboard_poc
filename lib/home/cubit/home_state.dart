part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeSuccess({required this.users});

  final List<User> users;
  @override
  List<Object?> get props => [users];
}

class HomeFailure extends HomeState {
  HomeFailure({required this.errorMessage});
  final String errorMessage;
}
