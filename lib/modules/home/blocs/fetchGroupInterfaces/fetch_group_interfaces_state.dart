part of 'fetch_group_interfaces_cubit.dart';

abstract class FetchGroupInterfacesState extends Equatable {
  const FetchGroupInterfacesState();

  @override
  List<Object?> get props => [];
}

class FetchGroupInterfacesInitial extends FetchGroupInterfacesState {}
class FetchGroupInterfacesInProgress extends FetchGroupInterfacesState {
  
}

class FetchGroupInterfacesSucceeded extends FetchGroupInterfacesState {
  final List<Interface> interfaces;
  

  const FetchGroupInterfacesSucceeded({
    required this.interfaces,
  });

 

  @override
  List<Object?> get props => [interfaces];
}

class FetchGroupInterfacesFailed extends ErrorState implements FetchGroupInterfacesState {
  const FetchGroupInterfacesFailed([Object? e]) : super(e);
}
