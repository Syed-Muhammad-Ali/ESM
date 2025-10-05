import 'package:european_single_marriage/model/fqa_model.dart';
import 'package:get/get.dart';

class HelpSupportController extends GetxController {
  final RxList<FaqModel> faqs =
      <FaqModel>[
        FaqModel(
          question: 'How do I update my profile?',
          answer:
              'Go to your profile and tap the edit icon to update your information.',
        ),
        FaqModel(
          question: 'How does the matchmaking work?',
          answer:
              'Matchmaking is based on your preferences and profile compatibility.',
        ),
        FaqModel(
          question: 'What are the premium features?',
          answer:
              'Premium features include unlimited swipes, see who liked you, and more.',
        ),
      ].obs;

  void toggleFaq(int index) {
    faqs[index].isExpanded = !faqs[index].isExpanded;
    faqs.refresh();
  }
}
