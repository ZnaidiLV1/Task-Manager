import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';

abstract class eventEmail extends Equatable {
  const eventEmail();
  @override
  List<Object> get props => [];
}

class fetchEmail extends eventEmail {
  final String refreshToken;
  const fetchEmail(this.refreshToken);
  @override
  List<Object> get props => [refreshToken];
}

abstract class emailState extends Equatable {
  const emailState();
  @override
  List<Object> get props => [];
}

class emailInitial extends emailState {}

class emailLoading extends emailState {}

class emailLoaded extends emailState {
  final String email;
  const emailLoaded(this.email);
  @override
  List<Object> get props => [email];
}

class EmailBloc extends Bloc<eventEmail, emailState> {
  EmailBloc() : super(emailInitial()) {
    void _onfetchEmail(fetchEmail event, Emitter<emailState> emit) {
      emit(emailLoading());
      Map<String, dynamic> data = Jwt.parseJwt(event.refreshToken);
      emit(emailLoaded(data["email"]));
    }

    on<fetchEmail>(_onfetchEmail);
  }
}
