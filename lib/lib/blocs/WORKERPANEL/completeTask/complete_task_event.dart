// lib/bloc/WORKERPANEL/completeTask/complete_task_event.dart

part of 'complete_task_bloc.dart';

abstract class CompleteTaskEvent extends Equatable {
  const CompleteTaskEvent();

  @override
  List<Object?> get props => [];
}

class WorkDoneChanged extends CompleteTaskEvent {
  final String workDone;

  const WorkDoneChanged(this.workDone);

  @override
  List<Object?> get props => [workDone];
}

class HoursWorkedChanged extends CompleteTaskEvent {
  final int hoursWorked;

  const HoursWorkedChanged(this.hoursWorked);

  @override
  List<Object?> get props => [hoursWorked];
}

class CompletionNotesChanged extends CompleteTaskEvent {
  final String completionNotes;

  const CompletionNotesChanged(this.completionNotes);

  @override
  List<Object?> get props => [completionNotes];
}

class PhotoAdded extends CompleteTaskEvent {
  final Map<String, dynamic> photo;

  const PhotoAdded(this.photo);

  @override
  List<Object?> get props => [photo];
}

class PhotoRemoved extends CompleteTaskEvent {
  final int index;

  const PhotoRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class PhotoCaptionChanged extends CompleteTaskEvent {
  final int index;
  final String caption;

  const PhotoCaptionChanged({required this.index, required this.caption});

  @override
  List<Object?> get props => [index, caption];
}

class PhotoUrlChanged extends CompleteTaskEvent {
  final int index;
  final String url;

  const PhotoUrlChanged({required this.index, required this.url});

  @override
  List<Object?> get props => [index, url];
}

class SubmitCompleteTask extends CompleteTaskEvent {
  final String taskId;

  const SubmitCompleteTask({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}

class ResetCompleteTask extends CompleteTaskEvent {}
