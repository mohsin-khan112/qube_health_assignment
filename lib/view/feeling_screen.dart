import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:qubic_health_assignment/constant/app_colors.dart';
import 'package:qubic_health_assignment/constant/app_image_path.dart';
import 'package:qubic_health_assignment/constant/app_strings.dart';
import 'package:qubic_health_assignment/model/user_submit_felling_response_model.dart';
import 'package:qubic_health_assignment/util/date_util.dart';
import 'package:qubic_health_assignment/view/video_player_screen.dart';

import '../util/text.dart';
import 'controller/felling_controller.dart';

class FeelingHistoryScreen extends StatefulWidget {
  const FeelingHistoryScreen({Key? key}) : super(key: key);

  @override
  _FeelingHistoryScreenState createState() => _FeelingHistoryScreenState();
}

class _FeelingHistoryScreenState extends State<FeelingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeelingController>(
      init: FeelingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              AppString.yourFellingHistory,
              style: TextStyle(color: AppColors.textColor, fontSize: 20),
            ),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Feeling list container
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22, top: 20),
                  child: _buildFeelingUi(),
                ),
                const SizedBox(height: 10),
                const Divider(
                  height: 0.1,
                  color: AppColors.borderColor,
                ),
                const SizedBox(height: 10),

                ///Calendar View
                _buildCalendarView(),
                const SizedBox(height: 24),
                const Divider(
                  height: 0.1,
                  color: AppColors.borderColor,
                ),
                const SizedBox(height: 16),

                ///Feeling List
                _buildFeelingList(controller),
                const SizedBox(height: 16),
                const Divider(
                  height: 0.1,
                  color: AppColors.borderColor,
                ),
                const SizedBox(height: 32),

                ///Video View
                _buildVideoView(controller)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeelingUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        labels(
          text: AppString.yourFellingFromLast30days,
          size: 16,
          color: AppColors.textColor,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 98,
            child: GetX<FeelingController>(
              builder: (controller) => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.iconSList.length,
                itemBuilder: (context, index) {
                  return fellingReactionList(controller, index);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 15,
                  );
                },
              ),
            ))
      ],
    );
  }

  Widget fellingReactionList(FeelingController controller, int index) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.containerColor,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              labels(
                text: '${controller.iconSList[index].percentage}%',
                size: 12,
                color: AppColors.textColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image:
                        AssetImage(controller.iconSList[index].reactionIcon!),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        labels(
          text: controller.iconSList[index].reactionName,
          size: 12,
          color: AppColors.textColor,
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return GetX<FeelingController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(left: 22, right: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: AppColors.currentDateLabel,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: labels(
                text: DateUtil.getFormattedDateWithYear(
                    controller.selectedDate.value),
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 70,
              child: ListView.separated(
                itemCount: controller.dates.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final dateTime = controller.dates[index];
                  return GestureDetector(
                    onTap: () {
                      controller.changeDate(dateTime);
                    },
                    child: Container(
                      height: 70,
                      width: 40,
                      decoration: BoxDecoration(
                        color: dateTime == controller.selectedDate.value
                            ? AppColors.dateBackgroundColor
                            : Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          labels(
                            text: DateUtil.getDayFromDate(dateTime)
                                .substring(0, 2),
                            textStyle: const TextStyle(
                                fontSize: 15, color: AppColors.borderColor),
                          ),
                          const SizedBox(height: 4),
                          labels(
                            text: DateUtil.getDateFromDateTime(dateTime)
                                .toString(),
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: dateTime == controller.selectedDate.value
                                  ? AppColors.selectedDateTextColor
                                  : AppColors.dateTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 20);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeelingList(FeelingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: controller.userHistoryFellingResponseModel?.data != null &&
              controller.userHistoryFellingResponseModel!.data!.feelingList!
                  .isNotEmpty
          ? _showFeelingList(controller)
          : _showNoFeelingListContainer(),
    );
  }

  Widget _showFeelingList(FeelingController controller) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller
              .userHistoryFellingResponseModel?.data?.feelingList?.length ??
          0,
      itemBuilder: (context, index) {
        final feeling = controller
            .userHistoryFellingResponseModel!.data!.feelingList![index];
        String timeRange = DateUtil.getTimeForFeelingList(feeling.submitTime!);
        return Row(
          children: [
            labels(
              text: timeRange,
              textStyle: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 35),
            Image.asset(
              controller.getFeelingImage(feeling),
            ),
            const SizedBox(width: 4),
            labels(
              text: feeling.feelingName,
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 32);
      },
    );
  }

  Widget _showNoFeelingListContainer() {
    return SizedBox(
      height: 80,
      child: Center(
        child: labels(
          text: AppString.noFeelingAvailable,
          textStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoView(FeelingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22),
      child: controller.userHistoryFellingResponseModel?.data?.videoArr != null
          ? Visibility(
              visible:
                  controller.userHistoryFellingResponseModel?.data?.videoArr !=
                          null &&
                      controller.userHistoryFellingResponseModel!.data!
                          .videoArr!.isNotEmpty,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labels(
                    text: controller.userHistoryFellingResponseModel!.data!
                        .videoArr![0].title,
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Opacity(
                    opacity: 0.4,
                    child: labels(
                      text: controller.userHistoryFellingResponseModel!.data!
                          .videoArr![0].description,
                      textAlign: TextAlign.start,
                      textStyle: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildVideoListView(
                      controller,
                      controller
                          .userHistoryFellingResponseModel!.data!.videoArr!),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            )
          : Container(),
    );
  }

  Widget _buildVideoListView(
      FeelingController controller, List<VideoArr> videoArr) {
    return SizedBox(
      height: 128,
      child: ListView.separated(
        itemCount: videoArr.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
        itemBuilder: (context, index) {
          final video =
              controller.userHistoryFellingResponseModel!.data!.videoArr![0];
          String videoId =
              video.youtubeUrl!.substring(video.youtubeUrl!.indexOf("v=") + 2);
          return GestureDetector(
            onTap: () {
              Get.to(
                () => VideoPlayerScreen(videoId: videoId),
              );
            },
            child: SizedBox(
              width: 208,
              height: 128,
              child: Stack(
                children: [
                  SizedBox(
                    width: 208,
                    height: 128,
                    child: Card(
                      elevation: 4,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.only(top: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        'https://img.youtube.com/vi/$videoId/0.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImagePath.videoPlayIcon,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget videoDetails(FeelingController controller) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labels(
            text: controller
                .userHistoryFellingResponseModel?.data?.videoArr![0].title,
            size: 18,
            color: AppColors.textColor,
          ),
          const SizedBox(
            height: 10,
          ),
          Opacity(
            opacity: 0.4,
            child: labels(
              text: controller.userHistoryFellingResponseModel?.data
                  ?.videoArr![0].description,
              size: 14,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 130,
            child: Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller
                    .userHistoryFellingResponseModel?.data?.videoArr?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 128,
                      width: 208,
                      child: Image.network(controller
                          .userHistoryFellingResponseModel!
                          .data!
                          .videoArr![index]
                          .youtubeUrl!),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
