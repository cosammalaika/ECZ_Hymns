import 'package:flutter/material.dart';

Rect sharePositionOriginForContext(
  BuildContext context, {
  GlobalKey? triggerKey,
}) {
  final BuildContext? triggerContext = triggerKey?.currentContext;
  final RenderObject? triggerRenderObject = triggerContext?.findRenderObject();

  if (triggerRenderObject is RenderBox &&
      triggerRenderObject.hasSize &&
      triggerRenderObject.size.width > 0 &&
      triggerRenderObject.size.height > 0) {
    return triggerRenderObject.localToGlobal(Offset.zero) &
        triggerRenderObject.size;
  }

  final RenderObject? overlayRenderObject =
      Overlay.maybeOf(context)?.context.findRenderObject();
  if (overlayRenderObject is RenderBox &&
      overlayRenderObject.hasSize &&
      overlayRenderObject.size.width > 0 &&
      overlayRenderObject.size.height > 0) {
    return Rect.fromCenter(
      center: overlayRenderObject
          .localToGlobal(overlayRenderObject.size.center(Offset.zero)),
      width: 1,
      height: 1,
    );
  }

  return const Rect.fromLTWH(0, 0, 1, 1);
}
