// lib/bloc/WORKERPANEL/completeTask/complete_task_state.dart

part of 'complete_task_bloc.dart';

class CompleteTaskState extends Equatable {
  const CompleteTaskState({
    this.workDone = '',
    this.hoursWorked = 0,
    this.completionNotes = '',
    this.photos = const [],
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
  });

  final String workDone;
  final int hoursWorked;
  final String completionNotes;
  final List<Map<String, dynamic>> photos;
  final String message;
  final PostApiStatus postApiStatus;

  CompleteTaskState copyWith({
    String? workDone,
    int? hoursWorked,
    String? completionNotes,
    List<Map<String, dynamic>>? photos,
    String? message,
    PostApiStatus? postApiStatus,
  }) {
    return CompleteTaskState(
      workDone: workDone ?? this.workDone,
      hoursWorked: hoursWorked ?? this.hoursWorked,
      completionNotes: completionNotes ?? this.completionNotes,
      photos: photos ?? this.photos,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
    );
  }

  @override
  List<Object?> get props => [
    workDone,
    hoursWorked,
    completionNotes,
    photos,
    message,
    postApiStatus,
  ];
}
