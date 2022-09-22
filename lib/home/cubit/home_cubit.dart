import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._userRepository) : super(HomeInitial());

  final UserRepository _userRepository;

  Future<void> getUsers() async {
    emit(HomeLoading());
    await Future.delayed(Duration(seconds: 2));
    try {
      final users = await _userRepository.getUsers();
      emit(HomeSuccess(users: users));
    } on Exception {
      emit(HomeFailure(errorMessage: 'Request failed or users not found'));
    }
    ;
  }
}
