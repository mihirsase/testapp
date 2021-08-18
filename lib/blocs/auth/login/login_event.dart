abstract class LoginEvent {}

class PerformLogin extends LoginEvent {
  final String email;
  final String password;

  PerformLogin({
    required final this.email,
    required final this.password,
  });
}


