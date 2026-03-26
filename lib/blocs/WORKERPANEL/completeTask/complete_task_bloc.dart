// lib/bloc/WORKERPANEL/completeTask/complete_task_bloc.dart

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/WORKERPANEL/completeTask/complete_task_model.dart';
import '../../../repository/WORKERPANEL/completeTask/complete_task_repository.dart';
import '../../../utils/enums.dart';

part 'complete_task_event.dart';
part 'complete_task_state.dart';

class CompleteTaskBloc extends Bloc<CompleteTaskEvent, CompleteTaskState> {
  final CompleteTaskRepository completeTaskRepository;

  CompleteTaskBloc({required this.completeTaskRepository})
    : super(const CompleteTaskState()) {
    // Work Done
    on<WorkDoneChanged>(_onWorkDoneChanged);

    // Hours Worked
    on<HoursWorkedChanged>(_onHoursWorkedChanged);

    // Completion Notes
    on<CompletionNotesChanged>(_onCompletionNotesChanged);

    // Photos
    on<PhotoAdded>(_onPhotoAdded);
    on<PhotoRemoved>(_onPhotoRemoved);
    on<PhotoCaptionChanged>(_onPhotoCaptionChanged);
    on<PhotoUrlChanged>(_onPhotoUrlChanged);

    // Submit
    on<SubmitCompleteTask>(_submitCompleteTask);

    // Reset
    on<ResetCompleteTask>(_resetCompleteTask);
  }

  void _onWorkDoneChanged(
    WorkDoneChanged event,
    Emitter<CompleteTaskState> emit,
  ) {
    emit(state.copyWith(workDone: event.workDone));
  }

  void _onHoursWorkedChanged(
    HoursWorkedChanged event,
    Emitter<CompleteTaskState> emit,
  ) {
    emit(state.copyWith(hoursWorked: event.hoursWorked));
  }

  void _onCompletionNotesChanged(
    CompletionNotesChanged event,
    Emitter<CompleteTaskState> emit,
  ) {
    emit(state.copyWith(completionNotes: event.completionNotes));
  }

  void _onPhotoAdded(PhotoAdded event, Emitter<CompleteTaskState> emit) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    updatedPhotos.add(event.photo);
    emit(state.copyWith(photos: updatedPhotos));
  }

  void _onPhotoRemoved(PhotoRemoved event, Emitter<CompleteTaskState> emit) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    if (event.index >= 0 && event.index < updatedPhotos.length) {
      updatedPhotos.removeAt(event.index);
      emit(state.copyWith(photos: updatedPhotos));
    }
  }

  void _onPhotoCaptionChanged(
    PhotoCaptionChanged event,
    Emitter<CompleteTaskState> emit,
  ) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    if (event.index >= 0 && event.index < updatedPhotos.length) {
      updatedPhotos[event.index]['caption'] = event.caption;
      emit(state.copyWith(photos: updatedPhotos));
    }
  }

  void _onPhotoUrlChanged(
    PhotoUrlChanged event,
    Emitter<CompleteTaskState> emit,
  ) {
    final updatedPhotos = List<Map<String, dynamic>>.from(state.photos);
    if (event.index >= 0 && event.index < updatedPhotos.length) {
      updatedPhotos[event.index]['url'] = event.url;
      emit(state.copyWith(photos: updatedPhotos));
    }
  }

  void _resetCompleteTask(
    ResetCompleteTask event,
    Emitter<CompleteTaskState> emit,
  ) {
    emit(const CompleteTaskState());
  }

  Future<void> _submitCompleteTask(
    SubmitCompleteTask event,
    Emitter<CompleteTaskState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      // Prepare the data for API - all fields are optional
      final Map<String, dynamic> data = {};

      // Add fields only if they have values
      if (state.workDone.isNotEmpty) {
        data["workDone"] = state.workDone;
      }

      if (state.hoursWorked > 0) {
        data["hoursWorked"] = state.hoursWorked;
      }

      if (state.completionNotes.isNotEmpty) {
        data["completionNotes"] = state.completionNotes;
      }

      // Add photos if any
      if (state.photos.isNotEmpty) {
        data["photos"] = state.photos.map((photo) {
          return {
            "url": photo['url'] ?? 'https://example.com/placeholder.jpg',
            "caption": photo['caption'] ?? '',
          };
        }).toList();
      }

      log('Submitting task completion data: $data');

      final CompleteTaskModel response = await completeTaskRepository
          .completetaskApi(data, event.taskId);

      if (response.success == true) {
        emit(
          state.copyWith(
            message: response.message ?? 'Task completed successfully',
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message ?? 'Failed to complete task',
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
