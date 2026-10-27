import 'package:checkpoint/data/models/courseModel.dart';
import 'package:checkpoint/data/models/lessonModel.dart';
import 'package:checkpoint/presentation/uikit/colors.dart';
import 'package:checkpoint/presentation/uikit/components/arrowLeft.dart';
import 'package:checkpoint/presentation/uikit/typography.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vize/vize.dart';

class VideoLessonScreen extends StatefulWidget {
  final Lesson lesson;
  final Course course;

  const VideoLessonScreen({super.key, required this.lesson, required this.course});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    final videoUrl = widget.lesson.videoUrl;

    if (videoUrl != null && videoUrl.isNotEmpty) {
      if (videoUrl.startsWith('http')) {
        controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      } else {
        controller = VideoPlayerController.asset(videoUrl);
      }

      initializeVideoPlayerFuture = controller.initialize().then((_) {
        controller.seekTo(Duration.zero);
        controller.play();
        controller.setLooping(false);
        controller.setVolume(0.0);

        controller.addListener(() {
          if (mounted) {
            setState(() {});
          }
        });
      });
    } else {
      initializeVideoPlayerFuture = Future.value();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: ps(h: 20, v: 30),
            child: Row(
              children: [
                GestureDetector(onTap: () => Navigator.pop(context, true), child: arrowLeft()),
                const Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    widget.lesson.title,
                    style: AppTypography.text1Semibold.copyWith(color: AppColors.dark, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                SizedBox(width: 40.fw),
              ],
            ),
          ),
          SizedBox(
            height: 220.fh,
            width: double.infinity,
            child: FutureBuilder<void>(
              future: initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (widget.lesson.videoUrl == null || widget.lesson.videoUrl!.isEmpty) {
                  return Padding(
                    padding: ps(h: 15),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16.r)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.videocam_off, size: 64, color: AppColors.light_grey),
                            SizedBox(height: 16.fh),
                            Text('Видео недоступно', style: AppTypography.text2Meduim.copyWith(color: AppColors.light_grey)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState != ConnectionState.done || !controller.value.isInitialized) {
                  return Padding(
                    padding: ps(h: 15),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(16.r)),
                      child: Center(child: CircularProgressIndicator(color: AppColors.active)),
                    ),
                  );
                }
                return Padding(
                  padding: ps(h: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Stack(
                      children: [
                        AspectRatio(aspectRatio: controller.value.aspectRatio, child: VideoPlayer(controller)),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: ps(h: 5),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.6), Colors.transparent]),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                VideoProgressIndicator(
                                  controller,
                                  allowScrubbing: true,
                                  colors: VideoProgressColors(playedColor: AppColors.active, bufferedColor: AppColors.light, backgroundColor: Colors.white.withOpacity(0.3)),
                                ),
                                SizedBox(height: 4.fh),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 30),
                                      onPressed: () {
                                        setState(() {
                                          controller.value.isPlaying ? controller.pause() : controller.play();
                                        });
                                      },
                                    ),
                                    const Spacer(),
                                    Text(formatDuration(controller.value.position), style: AppTypography.text3Meduim.copyWith(color: Colors.white)),
                                    SizedBox(width: 8.fw),
                                    IconButton(
                                      icon: Icon(controller.value.volume > 0 ? Icons.volume_up : Icons.volume_off, color: Colors.white, size: 27),
                                      onPressed: () {
                                        setState(() {
                                          if (controller.value.volume > 0) {
                                            controller.setVolume(0.0);
                                          } else {
                                            controller.setVolume(1.0);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: ps(h: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.fh),
                  if (widget.lesson.content != null && widget.lesson.content!.isNotEmpty) ...[Text(widget.lesson.content!, style: AppTypography.text2Meduim.copyWith(color: AppColors.dark)), SizedBox(height: 24.fh)],
                  // SizedBox(height: 40.fh),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50.fh,
                  //   child: ElevatedButton(
                  //     onPressed: _markAsCompleted,
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppColors.active,
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                  //     ),
                  //     child: Text('Отметить как пройденное', style: AppTypography.text2Semibold.copyWith(color: AppColors.white)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void markAsCompleted() {
  //   widget.lesson.isCompleted = true;
  //   Navigator.pop(context, true);
  // }

  String formatDuration(Duration position) {
    final minutes = position.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = position.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
