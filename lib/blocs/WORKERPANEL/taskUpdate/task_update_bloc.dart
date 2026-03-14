import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/WORKERPANEL/taskUpdate/task_update_model.dart';
import '../../../repository/WORKERPANEL/taskUpdate/task_update_repository.dart';
import '../../../utils/enums.dart';

part 'task_update_event.dart';
part 'task_update_state.dart';

class TaskUpdateBloc extends Bloc<TaskUpdateEvent, TaskUpdateState> {
  final TaskUpdateRepository taskUpdateRepository;

  TaskUpdateBloc({required this.taskUpdateRepository})
    : super(const TaskUpdateState()) {
    // Work Done
    on<WorkDoneChanged>(_onWorkDoneChanged);

    // Hours Worked
    on<HoursWorkedChanged>(_onHoursWorkedChanged);

    // Photos
    on<PhotoAdded>(_onPhotoAdded);
    on<PhotoRemoved>(_onPhotoRemoved);
    on<PhotoCaptionChanged>(_onPhotoCaptionChanged);

    // Issues
    on<IssueAdded>(_onIssueAdded);
    on<IssueRemoved>(_onIssueRemoved);
    on<IssueTypeChanged>(_onIssueTypeChanged);
    on<IssueDescriptionChanged>(_onIssueDescriptionChanged);
    on<IssueSeverityChanged>(_onIssueSeverityChanged);

    // Resources
    on<ResourceAdded>(_onResourceAdded);
    on<ResourceRemoved>(_onResourceRemoved);
    on<ResourceNameChanged>(_onResourceNameChanged);
    on<ResourceQuantityChanged>(_onResourceQuantityChanged);
    on<ResourceUnitChanged>(_onResourceUnitChanged);

    // Submit
    on<SubmitTaskUpdate>(_submitTaskUpdate);

    // Reset
    on<ResetTaskUpdate>(_resetTaskUpdate);
  }

  void _onWorkDoneChanged(
    WorkDoneChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    emit(state.copyWith(workDone: event.workDone));
  }

  void _onHoursWorkedChanged(
    HoursWorkedChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    emit(state.copyWith(hoursWorked: event.hoursWorked));
  }

  void _onPhotoAdded(PhotoAdded event, Emitter<TaskUpdateState> emit) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    updatedPhotos.add(event.photo);
    emit(state.copyWith(photos: updatedPhotos));
  }

  void _onPhotoRemoved(PhotoRemoved event, Emitter<TaskUpdateState> emit) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    if (event.index >= 0 && event.index < updatedPhotos.length) {
      updatedPhotos.removeAt(event.index);
      emit(state.copyWith(photos: updatedPhotos));
    }
  }

  void _onPhotoCaptionChanged(
    PhotoCaptionChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    if (event.index >= 0 && event.index < updatedPhotos.length) {
      updatedPhotos[event.index]['caption'] = event.caption;
      emit(state.copyWith(photos: updatedPhotos));
    }
  }

  void _onIssueAdded(IssueAdded event, Emitter<TaskUpdateState> emit) {
    final updatedIssues = List<Map<String, dynamic>>.from(state.issues);
    updatedIssues.add(event.issue);
    emit(state.copyWith(issues: updatedIssues));
  }

  void _onIssueRemoved(IssueRemoved event, Emitter<TaskUpdateState> emit) {
    final updatedIssues = List<Map<String, dynamic>>.from(state.issues);
    if (event.index >= 0 && event.index < updatedIssues.length) {
      updatedIssues.removeAt(event.index);
      emit(state.copyWith(issues: updatedIssues));
    }
  }

  void _onIssueTypeChanged(
    IssueTypeChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedIssues = List<Map<String, dynamic>>.from(state.issues);
    if (event.index >= 0 && event.index < updatedIssues.length) {
      updatedIssues[event.index]['type'] = event.type;
      emit(state.copyWith(issues: updatedIssues));
    }
  }

  void _onIssueDescriptionChanged(
    IssueDescriptionChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedIssues = List<Map<String, dynamic>>.from(state.issues);
    if (event.index >= 0 && event.index < updatedIssues.length) {
      updatedIssues[event.index]['description'] = event.description;
      emit(state.copyWith(issues: updatedIssues));
    }
  }

  void _onIssueSeverityChanged(
    IssueSeverityChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedIssues = List<Map<String, dynamic>>.from(state.issues);
    if (event.index >= 0 && event.index < updatedIssues.length) {
      updatedIssues[event.index]['severity'] = event.severity;
      emit(state.copyWith(issues: updatedIssues));
    }
  }

  void _onResourceAdded(ResourceAdded event, Emitter<TaskUpdateState> emit) {
    final updatedResources = List<Map<String, dynamic>>.from(state.resources);
    updatedResources.add(event.resource);
    emit(state.copyWith(resources: updatedResources));
  }

  void _onResourceRemoved(
    ResourceRemoved event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedResources = List<Map<String, dynamic>>.from(state.resources);
    if (event.index >= 0 && event.index < updatedResources.length) {
      updatedResources.removeAt(event.index);
      emit(state.copyWith(resources: updatedResources));
    }
  }

  void _onResourceNameChanged(
    ResourceNameChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedResources = List<Map<String, dynamic>>.from(state.resources);
    if (event.index >= 0 && event.index < updatedResources.length) {
      updatedResources[event.index]['name'] = event.name;
      emit(state.copyWith(resources: updatedResources));
    }
  }

  void _onResourceQuantityChanged(
    ResourceQuantityChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedResources = List<Map<String, dynamic>>.from(state.resources);
    if (event.index >= 0 && event.index < updatedResources.length) {
      updatedResources[event.index]['quantity'] = event.quantity;
      emit(state.copyWith(resources: updatedResources));
    }
  }

  void _onResourceUnitChanged(
    ResourceUnitChanged event,
    Emitter<TaskUpdateState> emit,
  ) {
    final updatedResources = List<Map<String, dynamic>>.from(state.resources);
    if (event.index >= 0 && event.index < updatedResources.length) {
      updatedResources[event.index]['unit'] = event.unit;
      emit(state.copyWith(resources: updatedResources));
    }
  }

  void _resetTaskUpdate(ResetTaskUpdate event, Emitter<TaskUpdateState> emit) {
    emit(const TaskUpdateState());
  }

  Future<void> _submitTaskUpdate(
    SubmitTaskUpdate event,
    Emitter<TaskUpdateState> emit,
  ) async {
    if (!state.isValid) {
      emit(
        state.copyWith(
          message: 'Please fill all required fields',
          postApiStatus: PostApiStatus.error,
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      // Prepare the data for API
      final Map<String, dynamic> data = {
        "taskId": event.taskId,
        "workDone": state.workDone,
        "hoursWorked": state.hoursWorked,
      };

      // Add photos if any
      if (state.photos.isNotEmpty) {
        data["photos"] = state.photos.map((photo) {
          return {
            "url": photo['url'] ?? 'https://example.com/placeholder.jpg',
            "caption": photo['caption'] ?? '',
          };
        }).toList();
      }

      // Add issues if any
      if (state.issues.isNotEmpty) {
        data["issues"] = state.issues.map((issue) {
          return {
            "type": issue['type'] ?? '',
            "description": issue['description'] ?? '',
            "severity": issue['severity'] ?? 'MEDIUM',
          };
        }).toList();
      }

      // Add resources if any
      if (state.resources.isNotEmpty) {
        data["resourcesUsed"] = state.resources.map((resource) {
          return {
            "name": resource['name'] ?? '',
            "quantity": resource['quantity'] ?? 1,
            "unit": resource['unit'] ?? 'units',
          };
        }).toList();
      }

      log('Submitting task update data: $data');

      final TaskUpdateModel response = await taskUpdateRepository.taskUpdateApi(
        data,
        event.taskId,
      );

      if (response.success == true) {
        emit(
          state.copyWith(
            message: response.message ?? 'Task updated successfully',
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message ?? 'Failed to update task',
            postApiStatus: PostApiStatus.error,
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          message: error.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }
}
