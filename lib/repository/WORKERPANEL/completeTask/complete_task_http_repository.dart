import 'dart:developer';
import 'dart:io';

import 'package:digifarmer/config/apiUrls/api_urls.dart';
import 'package:digifarmer/config/data/network/network_services_api.dart';
import 'package:digifarmer/model/WORKERPANEL/completeTask/complete_task_model.dart';
import 'package:digifarmer/repository/WORKERPANEL/completeTask/complete_task_repository.dart';
import 'package:dio/dio.dart';

class CompleteTaskHttpRepository implements CompleteTaskRepository {
  final _apiServices = NetworkApiServices();

  @override
  Future<CompleteTaskModel> completetaskApi(dynamic data, String taskId) async {
    // Build FormData for multipart upload
    final formData = FormData();

    // Add text fields only if present
    if (data['workDone'] != null && data['workDone'].toString().isNotEmpty) {
      formData.fields.add(MapEntry('workDone', data['workDone'].toString()));
    }

    if (data['hoursWorked'] != null && data['hoursWorked'] != 0) {
      formData.fields.add(
        MapEntry('hoursWorked', data['hoursWorked'].toString()),
      );
    }

    if (data['completionNotes'] != null &&
        data['completionNotes'].toString().isNotEmpty) {
      formData.fields.add(
        MapEntry('completionNotes', data['completionNotes'].toString()),
      );
    }

    // Add photos as actual files
    if (data['photos'] != null) {
      final photos = data['photos'] as List<Map<String, dynamic>>;
      for (final photo in photos) {
        final File? file = photo['file'];
        if (file != null && await file.exists()) {
          final fileName = file.path.split('/').last;
          log('Attaching photo: $fileName');
          formData.files.add(
            MapEntry(
              'photos',
              await MultipartFile.fromFile(file.path, filename: fileName),
            ),
          );
        }
      }
    }

    log('FormData fields: ${formData.fields}');
    log('FormData files count: ${formData.files.length}');

    // putApi already uses DioClient which auto-attaches the token via interceptor
    final response = await _apiServices.putApi(
      formData,
      ApiUrls.taskCompleteApi(taskId),
    );

    return CompleteTaskModel.fromJson(response);
  }
}
