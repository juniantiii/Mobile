import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PencarianController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final stt.SpeechToText speechToText = stt.SpeechToText();
  final RxBool isListening = false.obs;

  void startListening() async {
    if (!isListening.value && await speechToText.initialize()) {
      isListening.value = true;
      speechToText.listen(
        onResult: (result) {
          searchTextController.text = result.recognizedWords;
        },
      );
    } else if (isListening.value) {
      speechToText.stop();
      isListening.value = false;
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    speechToText.stop();
    super.onClose();
  }
}
