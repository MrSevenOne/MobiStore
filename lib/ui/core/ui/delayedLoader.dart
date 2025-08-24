import 'package:mobi_store/export.dart';

class DelayedLoader extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final Widget shimmer;
  final Duration delay;

  const DelayedLoader({
    super.key,
    required this.child,
    required this.isLoading,
    required this.shimmer,
    this.delay = const Duration(milliseconds: 500),
  });

  @override
  State<DelayedLoader> createState() => _DelayedLoaderState();
}

class _DelayedLoaderState extends State<DelayedLoader> {
  bool _showShimmer = false;

  @override
  void didUpdateWidget(covariant DelayedLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !_showShimmer) {
      Future.delayed(widget.delay, () {
        if (mounted && widget.isLoading) setState(() => _showShimmer = true);
      });
    } else if (!widget.isLoading && _showShimmer) {
      setState(() => _showShimmer = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showShimmer && widget.isLoading) return widget.shimmer;
    return widget.child;
  }
}
