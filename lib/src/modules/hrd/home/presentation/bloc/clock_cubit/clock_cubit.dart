import 'package:smatrackz/core.dart';

part 'clock_state.dart';

class ClockBloc extends Cubit<ClockState> {
  late final Timer _timer;

  ClockBloc() : super(ClockState(DateTime.now())) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      emit(ClockState(DateTime.now()));
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
