part of 'package:pod_player/src/pod_player.dart';

class _VideoOverlays extends StatelessWidget {
  final String tag;

  const _VideoOverlays({
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final podCtrs = Get.find<PodGetXVideoController>(tag: tag);

    ///Built in overlay
    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      id: 'overlay',
      builder: (podCtr) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: podCtr.isOverlayVisible ? 1 : 0,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              if (!kIsWeb) _MobileOverlay(tag: tag),
              if (kIsWeb) _WebOverlay(tag: tag),
              if (podCtrs.overlayBuilder != null)
                GetBuilder<PodGetXVideoController>(
                  id: 'update-all',
                  tag: tag,
                  builder: (podCtr) {
                    ///Custom overlay
                    final progressBar = PodProgressBar(
                      tag: tag,
                      podProgressBarConfig: podCtr.podProgressBarConfig,
                    );
                    final overlayOptions = OverLayOptions(
                      podVideoState: podCtr.podVideoState,
                      videoDuration: podCtr.videoDuration,
                      videoPosition: podCtr.videoPosition,
                      isFullScreen: podCtr.isFullScreen,
                      isLooping: podCtr.isLooping,
                      isOverlayVisible: podCtr.isOverlayVisible,
                      isMute: podCtr.isMute,
                      autoPlay: podCtr.autoPlay,
                      currentVideoPlaybackSpeed: podCtr.currentPaybackSpeed,
                      videoPlayBackSpeeds: podCtr.videoPlaybackSpeeds,
                      videoPlayerType: podCtr.videoPlayerType,
                      podProgresssBar: progressBar,
                    );

                    return podCtr.overlayBuilder!(overlayOptions);
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
