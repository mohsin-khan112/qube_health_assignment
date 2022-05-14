import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:qubic_health_assignment/constant/app_image_path.dart';
import 'package:qubic_health_assignment/constant/app_strings.dart';
import 'package:qubic_health_assignment/util/date_util.dart';

import '../../model/user_submit_felling_response_model.dart';
import '../../rest_api/api/api.dart';

class FeelingController extends GetxController {
  RxList<ReactionIconList> iconSList = <ReactionIconList>[].obs;
  UserHistoryFellingResponseModel? userHistoryFellingResponseModel;
  FlickManager? flickManager;

  final RxList<DateTime> dates = <DateTime>[].obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;

  @override
  void onInit() async {
    super.onInit();
    await _fetchData();
  }

  Future<void> fetchUserFellingData(String date) async {
    userHistoryFellingResponseModel =
        await UserSubmitFellingApi.userSubmitFellingApi(date);
    iconAdd();
    update();
  }

  iconAdd() {
    iconSList.value = [
      ReactionIconList(
          reactionIcon: AppImagePath.energeticImg,
          reactionName: AppString.energetic,
          percentage: userHistoryFellingResponseModel
              ?.data?.feelingPercentage?.energetic),
      ReactionIconList(
          reactionIcon: AppImagePath.sadImg,
          reactionName: AppString.sad,
          percentage:
              userHistoryFellingResponseModel?.data?.feelingPercentage?.sad),
      ReactionIconList(
          reactionIcon: AppImagePath.happyImg,
          reactionName: AppString.happy,
          percentage:
              userHistoryFellingResponseModel?.data?.feelingPercentage?.happy),
      ReactionIconList(
          reactionIcon: AppImagePath.angryImg,
          reactionName: AppString.angry,
          percentage:
              userHistoryFellingResponseModel?.data?.feelingPercentage?.angry),
      ReactionIconList(
          reactionIcon: AppImagePath.calmImg,
          reactionName: AppString.calm,
          percentage:
              userHistoryFellingResponseModel?.data?.feelingPercentage?.calm),
      ReactionIconList(
          reactionIcon: AppImagePath.boredImg,
          reactionName: AppString.bored,
          percentage:
              userHistoryFellingResponseModel?.data?.feelingPercentage?.bored),
      if (userHistoryFellingResponseModel?.data?.feelingPercentage?.love !=
          null)
        ReactionIconList(
            reactionIcon: AppImagePath.loveImg,
            reactionName: AppString.love,
            percentage: '0'),
    ];
  }

  Future<void> _fetchData() async {
    final dates = DateUtil.getSixDaysDate();
    selectedDate.value = dates[0];
    this.dates.value = dates;
    await fetchUserFellingData(
        DateUtil.getFormattedDateForAPI(selectedDate.value));
  }

  Future<void> changeDate(DateTime dateTime) async {
    selectedDate.value = dateTime;
    await fetchUserFellingData(DateUtil.getFormattedDateForAPI(dateTime));
  }

  String getFeelingImage(FeelingList feeling) {
    var path = AppImagePath.energeticImg;
    for (final reaction in iconSList) {
      if (reaction.reactionName == feeling.feelingName) {
        path = reaction.reactionIcon!;
      }
    }
    return path;
  }
}

class ReactionIconList {
  String? reactionIcon;
  String? reactionName;
  String? percentage;

  ReactionIconList({this.reactionIcon, this.reactionName, this.percentage});
}
