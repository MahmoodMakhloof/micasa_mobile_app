part of 'fetch_group_pics_cubit.dart';

abstract class FetchGroupPicsState extends Equatable {
  const FetchGroupPicsState();

  @override
  List<Object?> get props => [];
}

class FetchGroupPicsInitial extends FetchGroupPicsState {}

class FetchGroupPicsInProgress extends FetchGroupPicsState {}

class FetchGroupPicsSucceeded extends FetchGroupPicsState {
  final List<GroupPic> pics;

  const FetchGroupPicsSucceeded({
    required this.pics,
  });

  @override
  List<Object?> get props => [pics];
}

class FetchGroupPicsFailed extends ErrorState implements FetchGroupPicsState {
  const FetchGroupPicsFailed([Object? e]) : super(e);
}