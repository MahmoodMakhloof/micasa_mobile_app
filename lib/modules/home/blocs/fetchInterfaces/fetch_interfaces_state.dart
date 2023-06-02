part of 'fetch_interfaces_cubit.dart';

abstract class FetchInterfacesState extends Equatable {
  const FetchInterfacesState();

  @override
  List<Object?> get props => [];
}

class FetchInterfacesInitial extends FetchInterfacesState {}
class FetchInterfacesInProgress extends FetchInterfacesState {
  
}

class FetchInterfacesSucceeded extends FetchInterfacesState {
  final List<Interface> interfaces;
  

  const FetchInterfacesSucceeded({
    required this.interfaces,
  });

 

  @override
  List<Object?> get props => [interfaces];
}

class FetchInterfacesFailed extends ErrorState implements FetchInterfacesState {
  const FetchInterfacesFailed([Object? e]) : super(e);
}
