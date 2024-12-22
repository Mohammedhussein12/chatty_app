import 'package:chatty_app/rooms/data/models/category_model.dart';
import 'package:chatty_app/rooms/view_model/rooms_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/database_services.dart';
import '../data/models/room_model.dart';

class RoomsViewModel extends Cubit<RoomsStates> {
  RoomsViewModel() : super(RoomsInitial());
  List<RoomModel> rooms = [];

  Future<void> createRoom(RoomModel room) async {
    emit(CreateRoomLoading());
    try {
      await DatabaseUtils.createRoom(room);
      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomError(e.toString()));
    }
  }

  Future<void> getRooms() async {
    try {
      emit(GetRoomsLoading());
      rooms = await DatabaseUtils.getRooms();
      emit(GetRoomsSuccess());
    } catch (e) {
      emit(GetRoomsError(e.toString()));
    }
  }

  String getCategoryImageName(String categoryId) => CategoryModel.categories
      .firstWhere((category) => category.id == categoryId)
      .imageName;
}
