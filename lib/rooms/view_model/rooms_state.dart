abstract class RoomsStates {}

class RoomsInitial extends RoomsStates {}

class CreateRoomLoading extends RoomsStates {}

class CreateRoomSuccess extends RoomsStates {}

class CreateRoomError extends RoomsStates {
  final String error;

  CreateRoomError(this.error);
}

class GetRoomsLoading extends RoomsStates {}

class GetRoomsSuccess extends RoomsStates {}

class GetRoomsError extends RoomsStates {
  final String error;

  GetRoomsError(this.error);
}
