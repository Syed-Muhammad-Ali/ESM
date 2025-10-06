import 'package:european_single_marriage/controller/home%20controller/chat_controller.dart';
import 'package:european_single_marriage/core/common/custom_text.dart';
import 'package:european_single_marriage/core/extensions/size_box_extension.dart';
import 'package:european_single_marriage/core/utils/constant/app_colors.dart';
import 'package:european_single_marriage/core/utils/constant/app_images.dart';
import 'package:european_single_marriage/core/utils/constant/app_sizes.dart';
import 'package:european_single_marriage/core/utils/snackBar/snackbar_utils.dart';
import 'package:european_single_marriage/model/chat_model.dart';
import 'package:european_single_marriage/routes/app_routes.dart';
import 'package:european_single_marriage/views/app%20screens/dashboard%20screens/chat_text_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: AppColors.appBarColor,
            child: SafeArea(
              child: Center(
                child: CustomText(
                  title: "Chat",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          AppSizes.spaceBtwSections.heightBox,
          AppSizes.spaceBtwItems.heightBox,

          // 🔥 Firebase stream
          Expanded(
            child: StreamBuilder<List<ChatModel>>(
              stream: controller.fetchInboxStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No chats available"));
                }

                final chats = snapshot.data!;

                return ListView.builder(
                  itemCount: chats.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final chat = chats[index];

                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            print("chatId: ${chat.chatId}");
                            print("peerId: ${chat.peerId}");
                            print("peerImage: ${chat.peerImage}");
                            print("peerName: ${chat.peerName}");
                            print("peerName: ${chat.lastMessage}");

                            if (chat.chatId.isEmpty || chat.peerId.isEmpty) {
                              Utils.snackBar(
                                "Error",
                                "Invalid chat data.",
                                AppColors.red,
                              );
                              return;
                            }

                            Get.to(
                              () => MessageTextPage(
                                chatId: chat.chatId,
                                receiverId: chat.peerId,
                                userName: chat.peerName,
                                userImage: chat.peerImage,
                              ),
                            );
                          },

                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                chat.peerImage.isNotEmpty
                                    ? NetworkImage(chat.peerImage)
                                    : AssetImage(AppImages.imageURL)
                                        as ImageProvider,
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                title: chat.peerName,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              CustomText(
                                title: chat.last_message_time,
                                color: const Color(0xFF999999),
                                fontSize: (chat.unreadCount > 0) ? 14 : 12,
                                fontWeight:
                                    (chat.unreadCount > 0)
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      if (chat.isRead)
                                        const TextSpan(
                                          text: "✓✓ ",
                                          style: TextStyle(
                                            color: AppColors.blue,
                                            fontSize: 14,
                                          ),
                                        )
                                      else
                                        const TextSpan(
                                          text: "✓ ",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      TextSpan(
                                        text: chat.lastMessage,
                                        style: const TextStyle(
                                          color: Color(0xFF999999),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (chat.unreadCount > 0)
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1BE05E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomText(
                                    title: chat.unreadCount.toString(),
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Divider(color: Color(0xFFF2F2F2)),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addFriendPage),
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
