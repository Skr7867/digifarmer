part of 'task_update_bloc.dart';

class TaskUpdateState extends Equatable {
  const TaskUpdateState({
    this.workDone = '',
    this.hoursWorked = 0,
    this.photos = const [],
    this.issues = const [],
    this.resources = const [],
    this.message = '',
    this.postApiStatus = PostApiStatus.initial,
    this.isValid = false,
  });

  final String workDone;
  final int hoursWorked;
  final List<Map<String, dynamic>> photos;
  final List<Map<String, dynamic>> issues;
  final List<Map<String, dynamic>> resources;
  final String message;
  final PostApiStatus postApiStatus;
  final bool isValid;

  TaskUpdateState copyWith({
    String? workDone,
    int? hoursWorked,
    List<Map<String, dynamic>>? photos,
    List<Map<String, dynamic>>? issues,
    List<Map<String, dynamic>>? resources,
    String? message,
    PostApiStatus? postApiStatus,
    bool? isValid,
  }) {
    return TaskUpdateState(
      workDone: workDone ?? this.workDone,
      hoursWorked: hoursWorked ?? this.hoursWorked,
      photos: photos ?? this.photos,
      issues: issues ?? this.issues,
      resources: resources ?? this.resources,
      message: message ?? this.message,
      postApiStatus: postApiStatus ?? this.postApiStatus,
      isValid:
          isValid ??
          _validateForm(
            workDone ?? this.workDone,
            hoursWorked ?? this.hoursWorked,
          ),
    );
  }

  bool _validateForm(String workDone, int hoursWorked) {
    return workDone.isNotEmpty && hoursWorked > 0;
  }

  @override
  List<Object?> get props => [
    workDone,
    hoursWorked,
    photos,
    issues,
    resources,
    message,
    postApiStatus,
    isValid,
  ];
}
