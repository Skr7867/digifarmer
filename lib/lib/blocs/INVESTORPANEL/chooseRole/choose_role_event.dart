part of 'choose_role_bloc.dart';

abstract class ChooseRoleEvent extends Equatable {
  const ChooseRoleEvent();

  @override
  List<Object> get props => [];
}

class SetRole extends ChooseRoleEvent {
  final String role;

  const SetRole(this.role);

  @override
  List<Object> get props => [role];
}

class SetUniqueKey extends ChooseRoleEvent {
  final String uniqueKey;

  const SetUniqueKey(this.uniqueKey);

  @override
  List<Object> get props => [uniqueKey];
}

class SubmitRole extends ChooseRoleEvent {}
