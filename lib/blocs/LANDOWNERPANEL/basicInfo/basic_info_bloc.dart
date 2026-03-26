import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/LANDOWNERPANEL/saveBasicInfo/save_basic_info_repository.dart';
import '../../../utils/enums.dart';

part 'basic_info_event.dart';
part 'basic_info_state.dart';

class SaveBasicInfoBloc extends Bloc<SaveBasicInfoEvent, SaveBasicInfoState> {
  final SaveBasicInfoRepository saveBasicInfoRepository;

  SaveBasicInfoBloc(this.saveBasicInfoRepository)
    : super(const SaveBasicInfoState()) {
    on<SetUniqueKey>((event, emit) {
      emit(state.copyWith(uniqueKey: event.uniqueKey));
    });

    on<LandTitleChanged>((event, emit) {
      emit(state.copyWith(landTitle: event.landTitle));
    });

    on<SurveyNumberChanged>((event, emit) {
      emit(state.copyWith(surveyNumber: event.surveyNumber));
    });

    on<AreaValueChanged>((event, emit) {
      emit(state.copyWith(areaValue: event.areaValue));
    });

    on<AreaUnitChanged>((event, emit) {
      emit(state.copyWith(areaUnit: event.areaUnit));
    });

    on<TotalSizeChanged>((event, emit) {
      emit(state.copyWith(totalSize: event.totalSize));
    });

    on<DescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<SoilTypeChanged>((event, emit) {
      emit(state.copyWith(soilType: event.soilType));
    });

    on<WaterSourceChanged>((event, emit) {
      emit(state.copyWith(waterSource: event.waterSource));
    });

    on<RoadAccessChanged>((event, emit) {
      emit(state.copyWith(roadAccess: event.roadAccess));
    });

    on<ExpectedMonthlyRentChanged>((event, emit) {
      emit(state.copyWith(expectedMonthlyRent: event.expectedMonthlyRent));
    });

    on<MinimumLeaseDurationChanged>((event, emit) {
      emit(state.copyWith(minimumLeaseDuration: event.minimumLeaseDuration));
    });

    on<SubmitSaveBasicInfo>(_submitSaveBasicInfo);
    on<SaveDraftBasicInfo>(_saveDraftBasicInfo);
  }

  Future<void> _submitSaveBasicInfo(
    SubmitSaveBasicInfo event,
    Emitter<SaveBasicInfoState> emit,
  ) async {
    await _saveBasicInfo(emit, isDraft: false);
  }

  Future<void> _saveDraftBasicInfo(
    SaveDraftBasicInfo event,
    Emitter<SaveBasicInfoState> emit,
  ) async {
    await _saveBasicInfo(emit, isDraft: true);
  }

  Future<void> _saveBasicInfo(
    Emitter<SaveBasicInfoState> emit, {
    required bool isDraft,
  }) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "landTitle": state.landTitle,
        "surveyNumber": state.surveyNumber,
        "areaValue": state.areaValue,
        "areaUnit": state.areaUnit,
        "totalSize": state.totalSize,
        "description": state.description,
        "soilType": state.soilType,
        "waterSource": state.waterSource,
        "roadAccess": state.roadAccess,
        "expectedMonthlyRent": state.expectedMonthlyRent,
        "minimumLeaseDuration": state.minimumLeaseDuration,
      };

      // Add uniqueKey if available
      if (state.uniqueKey.isNotEmpty) {
        data['uniqueKey'] = state.uniqueKey;
      }

      final response = await saveBasicInfoRepository.saveBasicInfoApi(data);

      if (response.success == true) {
        emit(
          state.copyWith(
            tempId: response.data.tempId,
            currentStep: response.data.currentStep,
            ownerId: response.data.ownerId,
            createdBy: response.data.createdBy,
            createdByRole: response.data.createdByRole,
            nextStep: response.data.nextStep,
            expiresAt: response.data.expiresAt,
            message: response.message,
            postApiStatus: PostApiStatus.success,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.message,
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
