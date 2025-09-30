// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
// import '../data/auth_repository.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository repo;
//   AuthBloc(this.repo) : super(AuthInitial()) {
//     on((event, emit) async {
//       emit(AuthLoading());
//       final success = await repo.login(AutofillHints.email, AutofillHints.password);
//       if (success) {
//         emit(AuthSuccess());
//       } else {
//         emit(AuthFailure("Invalid credentials"));
//       }
//     });
//   }
// }


import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final success = await authRepository.login(event.email, event.password);
        if (success) {
          emit(AuthSuccess());
        }
      } catch (e) {
        emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
      }
    });
  }
}
