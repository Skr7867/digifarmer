import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/LANDOWNERPANEL/landLocation/land_location_repository.dart';
import '../../../utils/enums.dart';

part 'land_location_event.dart';
part 'land_location_state.dart';

class LandLocationBloc extends Bloc<LandLocationEvent, LandLocationState> {
  final LandLocationRepository landLocationRepository;

  LandLocationBloc(this.landLocationRepository)
    : super(const LandLocationState()) {
    on<SetTempId>((event, emit) {
      emit(state.copyWith(tempId: event.tempId));
    });

    on<AddressChanged>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<CityChanged>((event, emit) {
      emit(state.copyWith(city: event.city));
    });

    on<StateChanged>((event, emit) {
      emit(state.copyWith(state: event.state));
    });

    on<PinCodeChanged>((event, emit) {
      emit(state.copyWith(pinCode: event.pinCode));
    });

    on<VillageChanged>((event, emit) {
      emit(state.copyWith(village: event.village));
    });

    on<TehsilChanged>((event, emit) {
      emit(state.copyWith(tehsil: event.tehsil));
    });

    on<DistrictChanged>((event, emit) {
      emit(state.copyWith(district: event.district));
    });

    on<LatitudeChanged>((event, emit) {
      emit(state.copyWith(latitude: event.latitude));
    });

    on<LongitudeChanged>((event, emit) {
      emit(state.copyWith(longitude: event.longitude));
    });

    on<LocationImageChanged>((event, emit) {
      emit(state.copyWith(imageFile: event.imageFile));
    });

    on<SetLocationFromCoordinates>((event, emit) {
      emit(
        state.copyWith(
          latitude: event.latitude,
          longitude: event.longitude,
          address: event.address,
          city: event.city ?? state.city,
          state: event.state ?? state.state,
          pinCode: event.pinCode ?? state.pinCode,
          village: event.village ?? state.village,
          tehsil: event.tehsil ?? state.tehsil,
          district: event.district ?? state.district,
        ),
      );
    });

    on<SubmitLandLocation>(_submitLandLocation);
    on<ResetLocationState>((event, emit) {
      emit(const LandLocationState());
    });
  }

  Future<void> _submitLandLocation(
    SubmitLandLocation event,
    Emitter<LandLocationState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      // Log the state before submitting
      log("📤 SUBMITTING WITH STATE:");
      log("tempId: ${state.tempId}");
      log("address: ${state.address}");
      log("city: ${state.city}");
      log("state: ${state.state}");
      log("pinCode: ${state.pinCode}");
      log("village: ${state.village}");
      log("tehsil: ${state.tehsil}");
      log("district: ${state.district}");
      log("latitude: ${state.latitude}");
      log("longitude: ${state.longitude}");

      final Map<String, dynamic> data = {
        "tempId": state.tempId,
        "address": state.address,
        "city": state.city,
        "state": state.state,
        "pinCode": state.pinCode,
        "village": state.village,
        "tehsil": state.tehsil,
        "district": state.district,
      };

      // Add latitude and longitude only if they have values
      if (state.latitude != 0.0) {
        data['latitude'] = state.latitude;
      }

      if (state.longitude != 0.0) {
        data['longitude'] = state.longitude;
      }

      log("📦 FINAL DATA SENT TO API: $data");

      final response = await landLocationRepository.landLocationApi(data);

      if (response.success == true) {
        emit(
          state.copyWith(
            responseTempId: response.data.tempId,
            currentStep: response.data.currentStep,
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
      log("❌ SUBMIT ERROR: $error");
      emit(
        state.copyWith(
          message: error.toString(),
          postApiStatus: PostApiStatus.error,
        ),
      );
    }
  }
}
