import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:tms/theme/color.dart';
import 'package:tms/widgets/loading_indicator.dart';
import 'package:tms/widgets/text.dart';
import 'package:video_player/video_player.dart';

class DetailPage extends StatefulWidget {
  final dynamic data;
  const DetailPage(this.data, {super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  Future<bool> initializeVideo() async {
    _videoPlayerController = VideoPlayerController.network(widget.data.sourceUrl);
    await _videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      showOptions: false,
    );

    return true;
  }

  Widget showBody() {
    switch (widget.data.sourceType) {
      case 'HTML':
        return InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.data.sourceUrl)),
        );
      case 'IMG':
        return PhotoView(
          basePosition: Alignment.topCenter,
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          imageProvider: NetworkImage(widget.data.sourceUrl),
        );
      case 'PDF':
        return SfPdfViewer.network(widget.data.sourceUrl);
      case 'VDO':
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text(widget.data.headline, fontSize: 24),
          text(
            'โพสต์เมื่อ ${DateFormat('d MMM ${widget.data.startDate.year + 543} (HH:mmน.)').format(widget.data.startDate.toLocal())}',
            color: const Color(0xFF6F869A),
          ).paddingSymmetric(vertical: 10),
          text(widget.data.subHeadline, color: const Color(0xFF6F869A)),
          FutureBuilder(
            future: initializeVideo(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.black,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(controller: _chewieController!),
                  ),
                );
              }
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.black12, blurRadius: 2)],
                ),
                child: AspectRatio(aspectRatio: 16 / 9, child: loadingIndicator()),
              );
            },
          ).paddingSymmetric(vertical: 10),
        ]).paddingAll(20);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายละเอียด')),
      body: showBody(),
    );
  }
}
