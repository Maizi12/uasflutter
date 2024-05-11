part of 'enkrip_bloc.dart';

@immutable
sealed class EnkripEvent extends Equatable {
  EnkripEvent();
  @override
  List<Object> get props => [];
}

class enkrip extends EnkripEvent {
  // late String ResponseCode;
  // late String ResponseMessage;
  // dynamic Data;
  // // enkrip();
  // @override
  // // TODO: implement props
  // List<Object> get props => [ResponseCode, ResponseMessage, Data];
}

class CheckKey extends EnkripEvent {}
