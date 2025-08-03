import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_bridge/imports.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginState()) {
    on<getLoginEvent>(_getLogin);
  }

  FutureOr<void> _getLogin(
      getLoginEvent event, Emitter<ParentState> emit) async {
    emit(state.copyWith()
      ..status = Status.loading
      ..isChanged = !state.isChanged);

    Either<Failure, LoginResponseModel> result = await loginUsecase(
        LoginRequestModel(
            email: event.requestModel.email.toLowerCase().trim(),
            password: event.requestModel.password));

    result.fold(
      (failure) {
        emit(state.copyWith()
          ..status = Status.error
          ..isChanged = !state.isChanged
          ..errorMessage = failure.toErrorModel().message);
      },
      (LoginResponseModel loginData) {
        emit(state.copyWith()
          ..isChanged = !state.isChanged
          ..status = Status.success
          ..loginResponseModel = loginData);
      },
    );
  }
}
