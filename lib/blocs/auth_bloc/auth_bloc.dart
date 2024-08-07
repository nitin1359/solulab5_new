import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solulab5/models/auth_response.dart';
import 'package:solulab5/models/user.dart';
import 'package:solulab5/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response =
            await authRepository.signIn(event.email, event.password);

        if (response.status == 200) {
          final authResponse = AuthResponse.fromJson(response.data);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', authResponse.accessToken);
          await prefs.setString('refresh_token', authResponse.refreshToken);
          emit(AuthSuccess(authResponse));
        } else {
          emit(AuthFailure(error: response.message));
        }
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await authRepository.signUp(event.user);
        if (response.status == 201) {
          final authResponse = AuthResponse.fromJson(response.data);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', authResponse.accessToken);
          await prefs.setString('refresh_token', authResponse.refreshToken);
          emit(AuthSuccess(authResponse));
        } else {
          emit(AuthFailure(error: response.message));
        }
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}