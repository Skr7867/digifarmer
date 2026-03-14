part of 'task_update_bloc.dart';

abstract class TaskUpdateEvent extends Equatable {
  const TaskUpdateEvent();

  @override
  List<Object?> get props => [];
}

class WorkDoneChanged extends TaskUpdateEvent {
  final String workDone;

  const WorkDoneChanged(this.workDone);

  @override
  List<Object?> get props => [workDone];
}

class HoursWorkedChanged extends TaskUpdateEvent {
  final int hoursWorked;

  const HoursWorkedChanged(this.hoursWorked);

  @override
  List<Object?> get props => [hoursWorked];
}

class PhotoAdded extends TaskUpdateEvent {
  final Map<String, dynamic> photo;

  const PhotoAdded(this.photo);

  @override
  List<Object?> get props => [photo];
}

class PhotoRemoved extends TaskUpdateEvent {
  final int index;

  const PhotoRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class PhotoCaptionChanged extends TaskUpdateEvent {
  final int index;
  final String caption;

  const PhotoCaptionChanged({required this.index, required this.caption});

  @override
  List<Object?> get props => [index, caption];
}

class IssueAdded extends TaskUpdateEvent {
  final Map<String, dynamic> issue;

  const IssueAdded(this.issue);

  @override
  List<Object?> get props => [issue];
}

class IssueRemoved extends TaskUpdateEvent {
  final int index;

  const IssueRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class IssueTypeChanged extends TaskUpdateEvent {
  final int index;
  final String type;

  const IssueTypeChanged({required this.index, required this.type});

  @override
  List<Object?> get props => [index, type];
}

class IssueDescriptionChanged extends TaskUpdateEvent {
  final int index;
  final String description;

  const IssueDescriptionChanged({
    required this.index,
    required this.description,
  });

  @override
  List<Object?> get props => [index, description];
}

class IssueSeverityChanged extends TaskUpdateEvent {
  final int index;
  final String severity;

  const IssueSeverityChanged({required this.index, required this.severity});

  @override
  List<Object?> get props => [index, severity];
}

class ResourceAdded extends TaskUpdateEvent {
  final Map<String, dynamic> resource;

  const ResourceAdded(this.resource);

  @override
  List<Object?> get props => [resource];
}

class ResourceRemoved extends TaskUpdateEvent {
  final int index;

  const ResourceRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class ResourceNameChanged extends TaskUpdateEvent {
  final int index;
  final String name;

  const ResourceNameChanged({required this.index, required this.name});

  @override
  List<Object?> get props => [index, name];
}

class ResourceQuantityChanged extends TaskUpdateEvent {
  final int index;
  final int quantity;

  const ResourceQuantityChanged({required this.index, required this.quantity});

  @override
  List<Object?> get props => [index, quantity];
}

class ResourceUnitChanged extends TaskUpdateEvent {
  final int index;
  final String unit;

  const ResourceUnitChanged({required this.index, required this.unit});

  @override
  List<Object?> get props => [index, unit];
}

class SubmitTaskUpdate extends TaskUpdateEvent {
  final String taskId;

  const SubmitTaskUpdate({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}

class ResetTaskUpdate extends TaskUpdateEvent {}
