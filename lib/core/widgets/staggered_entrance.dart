import 'package:flutter/material.dart';

/// Fades and slides content in with a per-index delay (list / settings).
class StaggeredEntrance extends StatefulWidget {
  const StaggeredEntrance({
    super.key,
    required this.index,
    required this.child,
    this.delayPerItem = const Duration(milliseconds: 45),
    this.duration = const Duration(milliseconds: 380),
    this.slideOffset = const Offset(0, 0.08),
  });

  final int index;
  final Widget child;
  final Duration delayPerItem;
  final Duration duration;
  final Offset slideOffset;

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    final delay = widget.delayPerItem * widget.index;
    Future<void>.delayed(delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : widget.slideOffset,
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
