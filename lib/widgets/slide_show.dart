import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

///Displays images in a slide view with an indicator.
///
///Use `SlideShow().show(BuildContext)` to display the slider.
///
class SlideShow extends StatefulWidget {
  ///Slide show initial displayed image index, defaults to `0`.
  ///
  final int initialIndex;

  ///Displayed images.
  ///
  ///this propery must not be null.
  final List<ImageProvider> images;

  ///Displays images in a slide view with an indicator.
  ///
  const SlideShow({
    Key? key,
    this.initialIndex = 0,
    required this.images,
  }) : super(key: key);

  ///Displays the current image slider.
  ///
  Future<void> show(BuildContext context) async {
    return Navigator.of(context, rootNavigator: true).push<void>(
      _FadePageRoute(
          duration: const Duration(milliseconds: 150), builder: (_) => this),
    );
  }

  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  late List<ImageProvider> _images;
  late final PageController _pageController;

  @override
  void initState() {
    _images = widget.images;

    _pageController = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: PhotoViewGallery.builder(
                itemCount: _images.length,
                pageController: _pageController,
                builder: (context, index) {
                  final imageProvider = _images[index];

                  return PhotoViewGalleryPageOptions(
                    imageProvider: imageProvider,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: imageProvider.toString()),
                    initialScale: PhotoViewComputedScale.contained,
                  );
                },
                // enableRotation: true,
                loadingBuilder: (context, event) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
            const Align(
              alignment: AlignmentDirectional(-0.9, -0.9),
              child: BackButton(),
            ),
            if (_images.length > 1)
              Align(
                alignment: const Alignment(0, 0.9),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  onDotClicked: (index) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.decelerate,
                    );
                  },
                  count: _images.length,
                  effect: WormEffect(
                    activeDotColor: CColors.primary,
                    dotColor: Colors.grey.shade300,
                    dotHeight: 13,
                    dotWidth: 26,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _FadePageRoute extends PageRouteBuilder {
  final WidgetBuilder builder;
  _FadePageRoute({
    required this.builder,
    Duration duration = const Duration(milliseconds: 200),
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: duration,
        );
}
