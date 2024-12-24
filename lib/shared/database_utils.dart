import 'package:chatty_app/chat/data/models/message_model.dart';
import 'package:chatty_app/rooms/data/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/data/models/user_model.dart';

class DatabaseUtils {
  static CollectionReference<UserModel> getUsersCollection() {
    CollectionReference<UserModel> usersCollection = FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
          fromFirestore: (documentSnapshot, options) =>
              UserModel.fromJson(documentSnapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
    return usersCollection;
  }

  static CollectionReference<RoomModel> getRoomsCollection() {
    CollectionReference<RoomModel> roomsCollection = FirebaseFirestore.instance
        .collection(RoomModel.collectionName)
        .withConverter<RoomModel>(
          fromFirestore: (documentSnapshot, options) =>
              RoomModel.fromJson(documentSnapshot.data()!),
          toFirestore: (roomModel, options) => roomModel.toJson(),
        );
    return roomsCollection;
  }

  static CollectionReference<MessageModel> getMessagesCollection(
      String roomId) {
    final messagesCollection = getRoomsCollection()
        .doc(roomId)
        .collection(MessageModel.collectionName)
        .withConverter<MessageModel>(
          fromFirestore: (documentSnapshot, options) =>
              MessageModel.fromJson(documentSnapshot.data()!),
          toFirestore: (messageModel, options) => messageModel.toJson(),
        );
    return messagesCollection;
  }

  static Future<UserModel> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user =
        UserModel(id: credential.user!.uid, name: name, email: email);
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    await usersCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login(
      {required String email, required String password}) async {
    UserCredential credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentSnapshot<UserModel> documentSnapShot =
        await usersCollection.doc(credential.user!.uid).get();
    return documentSnapShot.data()!;
  }

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<List<RoomModel>> getRooms() async {
    final CollectionReference<RoomModel> roomsCollection = getRoomsCollection();
    final QuerySnapshot<RoomModel> querySnapShot = await roomsCollection.get();
    return querySnapShot.docs
        .map((documentSnapShot) => documentSnapShot.data())
        .toList();
  }

  static Future<void> createRoom(RoomModel room) async {
    final CollectionReference<RoomModel> roomsCollection = getRoomsCollection();
    final DocumentReference<RoomModel> documentReference =
        roomsCollection.doc();
    room.id = documentReference.id;
    await documentReference.set(room);
  }

  static Future<void> insertMessageToRoom(MessageModel message) async {
    final CollectionReference<MessageModel> messagesCollection = getMessagesCollection(message.roomId);
    final doc = messagesCollection.doc();
    message.id = doc.id;
    doc.set(message);
  }

  static Stream<List<MessageModel>> getRoomMessages(String roomId) {
    final CollectionReference<MessageModel> messagesCollection = getMessagesCollection(roomId);
    return messagesCollection.orderBy('dateTime',descending: true).snapshots().map((querySnapShot) => querySnapShot.docs.map((doc) => doc.data()).toList());
  }
}
