import 'package:equatable/equatable.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<Map<String, dynamic>> users;
  UsersLoaded(this.users);
  @override
  List<Object?> get props => [users];
}

class UsersError extends UsersState {
  UsersError(String s);
}
