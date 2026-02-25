part of 'choose_role_bloc.dart';

class ChooseRoleState extends Equatable {
  const ChooseRoleState({
    this.uniqueKey = '',
    this.role = '',
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String uniqueKey;
  final String role;
  final String message;
  final PostApiStatus postApiStatus;

  ChooseRoleState copyWith({
    String? uniqueKey,
    String? role,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return ChooseRoleState(
      uniqueKey: uniqueKey ?? this.uniqueKey,
      role: role ?? this.role,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object> get props => [uniqueKey, role, message, postApiStatus];
}
