import 'package:chatty_app/auth/view_model/auth_view_model.dart';
import 'package:chatty_app/chat/view_model/chat_states.dart';
import 'package:chatty_app/shared/error_indicator.dart';
import 'package:chatty_app/shared/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_theme.dart';
import '../../data/models/message_model.dart';
import '../../view_model/chat_view_model.dart';
import '../widgets/received_message.dart';
import '../widgets/sent_message.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/ChatScreen';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatViewModel = ChatViewModel();
  List<MessageModel> messages = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      chatViewModel.roomId =
          ModalRoute.of(context)?.settings.arguments as String;
      chatViewModel.getMessagesStream();
      chatViewModel.currentUser =
          BlocProvider.of<AuthViewModel>(context).currentUser!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('Chat App'),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_image.png'),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.12),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
                child: Material(
                  borderRadius: BorderRadius.circular(16.0.r),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 12,
                  child: Container(
                    color: AppTheme.white,
                    padding: EdgeInsets.all(16.sp),
                    child: Column(
                      children: [
                        Expanded(
                          child: BlocBuilder<ChatViewModel, ChatStates>(
                            bloc: chatViewModel,
                            buildWhen: (previous, current) =>
                                current is GetMessagesStreamLoading ||
                                previous is GetMessagesStreamLoading,
                            builder: (context, state) {
                              if (state is GetMessagesStreamLoading) {
                                return const LoadingIndicator();
                              } else if (state is GetMessagesStreamError) {
                                return ErrorIndicator(
                                  message: state.error,
                                );
                              } else if (state is GetMessagesStreamSuccess) {
                                return StreamBuilder(
                                  stream: state.messagesStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      messages = snapshot.data!;
                                    }
                                    return ListView.separated(
                                      reverse: true,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 12.h),
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        final message = messages[index];
                                        final isMyMessage = chatViewModel
                                            .isMyMessage(message.senderId);
                                        return isMyMessage
                                            ? SentMessage(message: message)
                                            : ReceivedMessage(message: message);
                                      },
                                      itemCount: messages.length,
                                    );
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: chatViewModel.messagesController,
                                cursorColor: AppTheme.primary,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 8),
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppTheme.grey),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppTheme.grey),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppTheme.grey),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  hintText: 'Type a message',
                                  hintStyle: TextStyle(
                                    color: AppTheme.grey,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 12.h,
                                ),
                                backgroundColor: AppTheme.primary,
                                foregroundColor: AppTheme.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => chatViewModel.sendMessage(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Send',
                                    style: TextStyle(
                                      color: AppTheme.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(
                                    Icons.send,
                                    color: AppTheme.white,
                                    size: 22.sp,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
