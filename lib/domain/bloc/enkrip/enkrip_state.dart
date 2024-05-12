part of 'enkrip_bloc.dart';

@immutable
sealed class EnkripState extends Equatable {
  const EnkripState();
  @override
  List<Object> get props => [];
}

class EnkripInitial extends EnkripState {}

class EnkripLoading extends EnkripState {}

class SuccessEnkrip extends EnkripState {
  final dynamic result;

  SuccessEnkrip({required this.result});
  @override
  List<Object> get props => [result];
}

class FailedEnkrip extends EnkripState {
  final MetaModel metaModel;

  FailedEnkrip({required this.metaModel});

  @override
  List<Object> get props => [metaModel];
}
