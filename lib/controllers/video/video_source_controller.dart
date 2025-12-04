import 'package:get/get.dart';

/// 视频源控制器
class VideoSourceController extends GetxController{
  RxString videoRul = ''.obs;

  void setVideoRul(String url){
    videoRul.value = url;
  }
}