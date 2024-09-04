part of 'pop_up_bloc.dart';

abstract class PopUpEvent extends Equatable {
  const PopUpEvent();

  @override
  List<Object> get props => [];
}

class ShowPopupEvent extends PopUpEvent {}

class HidePopupEvent extends PopUpEvent {}
