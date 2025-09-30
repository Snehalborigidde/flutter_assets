import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/users_repository.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserRepository repository;

  UsersBloc(this.repository) : super(UsersInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        final users = await repository.fetchUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError('Failed to load users'));
      }
    });
  }
}
