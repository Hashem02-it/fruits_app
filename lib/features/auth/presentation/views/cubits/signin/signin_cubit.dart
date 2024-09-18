import 'package:bloc/bloc.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entitiy.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;

  Future<void> signinUser(String email, String password) async {
    emit(SigninLoading());
    final result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) {
        emit(SigninFailure(message: failure.message));
      },
      (userEntitiy) {
        emit(SigninSuccess(userEntitiy: userEntitiy));
      },
    );
  }
}
