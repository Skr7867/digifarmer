import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../repository/personalInfo/personal_info_repository.dart';
import '../../utils/enums.dart';
part 'personal_info_event.dart';
part 'personal_info_state.dart';

class PersonalInfoBloc extends Bloc<PersonalInfoEvent, PersonalInfoState> {
  final PersonalInfoRepository personalInfoRepository;

  PersonalInfoBloc(this.personalInfoRepository)
    : super(const PersonalInfoState()) {
    on<SetUniqueKey>((event, emit) {
      emit(state.copyWith(uniqueKey: event.uniqueKey));
    });

    on<FullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<DobChanged>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.dateOfBirth));
    });

    on<PanChanged>((event, emit) {
      emit(state.copyWith(panNumber: event.panNumber));
    });

    on<AadhaarChanged>((event, emit) {
      emit(state.copyWith(aadhaarNumber: event.aadhaarNumber));
    });

    on<AddressChanged>((event, emit) {
      emit(
        state.copyWith(
          houseNumber: event.houseNumber,
          street: event.street,
          area: event.area,
          city: event.city,
          state: event.state,
          pinCode: event.pinCode,
        ),
      );
    });

    on<SubmitPersonalInfo>(_submitPersonalInfo);
  }

  Future<void> _submitPersonalInfo(
    SubmitPersonalInfo event,
    Emitter<PersonalInfoState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "uniqueKey": state.uniqueKey,
        "fullName": state.fullName,
        "dateOfBirth": state.dateOfBirth,
        "panNumber": state.panNumber,
        "aadhaarNumber": state.aadhaarNumber,
        "address": {
          "houseNumber": state.houseNumber,
          "street": state.street,
          "area": state.area,
          "city": state.city,
          "state": state.state,
          "pinCode": state.pinCode,
        },
      };

      final response = await personalInfoRepository.personalInfoApi(data);

      if (response.success == true) {
        emit(
          state.copyWith(
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
