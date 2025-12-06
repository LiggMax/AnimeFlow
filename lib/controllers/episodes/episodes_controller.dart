import 'package:get/get.dart';

class EpisodesController extends GetxController {
  final RxString episodeTitle = ''.obs;

  void setEpisodeTitle(String title) {
    episodeTitle.value = title;
  }
}
