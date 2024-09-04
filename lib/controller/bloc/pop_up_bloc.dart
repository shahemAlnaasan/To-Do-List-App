import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'pop_up_event.dart';
part 'pop_up_state.dart';

class PopUpBloc extends Bloc<PopUpEvent, PopupState> {
  PopUpBloc() : super(PopupState(isVisible: false)) {
    on<PopUpEvent>((event, emit) {
      if (event is ShowPopupEvent) {
        emit(PopupState(isVisible: true));

        Future.delayed(const Duration(seconds: 5), () {
          add(HidePopupEvent());
        });
      } else if (event is HidePopupEvent) {
        emit(PopupState(isVisible: false));
      }
    });
  }
}
