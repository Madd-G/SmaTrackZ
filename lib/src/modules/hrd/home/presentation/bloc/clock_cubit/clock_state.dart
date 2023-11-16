part of 'clock_cubit.dart';

class ClockState extends Equatable {
  final DateTime time;

  const ClockState(this.time);

  @override
  List<Object?> get props => [time];
}