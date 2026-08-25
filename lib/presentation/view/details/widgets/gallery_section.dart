import 'package:control_loop_test/res/theme/theme.dart';
import 'package:control_loop_test/utils/responsiveSize.dart';
import 'package:flutter/material.dart';

class GallerySection extends StatelessWidget {
  final List<String> images;

  const GallerySection({super.key, required this.images});

  void _openFullScreen(BuildContext context, int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: CustomColors.black,
        pageBuilder: (_, __, ___) => _FullScreenGallery(
          images: images,
          initialIndex: index,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();

    return Row(
      children: List.generate(images.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index == images.length - 1 ? 0 : 12.rw(context),
            ),
            child: GestureDetector(
              onTap: () => _openFullScreen(context, index),
              child: ClipRRect(
                borderRadius: .circular(8),
                child: AspectRatio(
                  aspectRatio: 112 / 92,
                  child: Image.asset(images[index], fit: .cover),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenGallery({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.black,
      body: Stack(
        fit: .expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Center(
                  child: Image.asset(
                    widget.images[index],
                    fit: .contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Align(
              alignment: .topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: CustomColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
