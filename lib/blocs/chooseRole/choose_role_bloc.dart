import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:digifarmer/repository/chooseRole/choose_role_repository.dart';
import 'package:digifarmer/utils/enums.dart';

part 'choose_role_event.dart';
part 'choose_role_state.dart';

class ChooseRoleBloc extends Bloc<ChooseRoleEvent, ChooseRoleState> {
  final ChooseRoleRepository chooseRoleRepository;

  ChooseRoleBloc(this.chooseRoleRepository) : super(const ChooseRoleState()) {
    on<SetUniqueKey>(_setUniqueKey);
    on<SetRole>(_setRole);
    on<SubmitRole>(_submitRole);
  }

  void _setUniqueKey(SetUniqueKey event, Emitter<ChooseRoleState> emit) {
    emit(state.copyWith(uniqueKey: event.uniqueKey));
  }

  void _setRole(SetRole event, Emitter<ChooseRoleState> emit) {
    emit(state.copyWith(role: event.role));
  }

  Future<void> _submitRole(
    SubmitRole event,
    Emitter<ChooseRoleState> emit,
  ) async {
    try {
      emit(state.copyWith(postApiStatus: PostApiStatus.loading));

      final Map<String, dynamic> data = {
        "uniqueKey": state.uniqueKey,
        "role": state.role,
      };

      final response = await chooseRoleRepository.chooseRoleApi(data);

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
