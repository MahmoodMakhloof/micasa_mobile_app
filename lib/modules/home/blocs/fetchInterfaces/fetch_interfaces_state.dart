part of 'fetch_interfaces_cubit.dart';

abstract class FetchInterfacesState extends Equatable {
  const FetchInterfacesState();

  @override
  List<Object?> get props => [];
}

class FetchInterfacesInitial extends FetchInterfacesState {}

class FetchInterfacesInProgress extends FetchInterfacesState {}

class FetchInterfacesSucceeded extends FetchInterfacesState {
  final List<Interface> allBoardsInterfaces;
  final List<Interface> singleBoardInterfaces;
  final List<Interface> inGroupInterfaces;
  final List<Interface> toGroupInterfaces;

  const FetchInterfacesSucceeded({
    required this.allBoardsInterfaces,
    required this.singleBoardInterfaces,
    required this.inGroupInterfaces,
    required this.toGroupInterfaces,
  });

  @override
  List<Object?> get props => [allBoardsInterfaces,singleBoardInterfaces,inGroupInterfaces,toGroupInterfaces];
}

class FetchInterfacesFailed extends ErrorState implements FetchInterfacesState {
  const FetchInterfacesFailed([Object? e]) : super(e);
}
