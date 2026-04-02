import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HymnsPageBackground extends StatelessWidget {
  final Widget child;
  final Color? primaryColor;
  final Color? accentColor;
  final Color? accentCoolColor;

  const HymnsPageBackground({
    super.key,
    required this.child,
    this.primaryColor,
    this.accentColor,
    this.accentCoolColor,
  });

  @override
  Widget build(BuildContext context) {
    final HymnsUiPalette ui = context.hymnsPalette;
    final Color resolvedPrimary = primaryColor ?? AppColors.primary;
    final Color resolvedAccent = accentColor ?? AppColors.accent;
    final Color resolvedAccentCool = accentCoolColor ?? AppColors.accentCool;
    final Color topBackgroundWash = Color.alphaBlend(
      (ui.isDark ? resolvedPrimary : resolvedAccentCool)
          .withOpacity(ui.isDark ? 0.22 : 0.58),
      ui.background,
    );
    final Color middleBackgroundWash = Color.alphaBlend(
      resolvedAccent.withOpacity(ui.isDark ? 0.08 : 0.05),
      ui.background,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            topBackgroundWash,
            middleBackgroundWash,
            ui.background,
          ],
          stops: const <double>[0.0, 0.24, 1.0],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: -120,
            right: -80,
            child: _AmbientOrb(
              size: 280,
              colors: <Color>[
                resolvedAccent.withOpacity(ui.isDark ? 0.18 : 0.20),
                resolvedAccent.withOpacity(ui.isDark ? 0.02 : 0.03),
              ],
            ),
          ),
          Positioned(
            top: -20,
            left: -120,
            child: _AmbientOrb(
              size: 260,
              colors: <Color>[
                resolvedPrimary.withOpacity(ui.isDark ? 0.18 : 0.12),
                resolvedPrimary.withOpacity(ui.isDark ? 0.03 : 0.02),
              ],
            ),
          ),
          Positioned(
            bottom: -120,
            right: -80,
            child: _AmbientOrb(
              size: 240,
              colors: <Color>[
                resolvedAccentCool.withOpacity(ui.isDark ? 0.28 : 0.82),
                resolvedAccentCool.withOpacity(0.0),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class HymnsSurfaceCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final BorderSide? borderSide;
  final double radius;

  const HymnsSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.onTap,
    this.color,
    this.borderSide,
    this.radius = 22,
  });

  @override
  State<HymnsSurfaceCard> createState() => _HymnsSurfaceCardState();
}

class _HymnsSurfaceCardState extends State<HymnsSurfaceCard> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed == value) {
      return;
    }
    setState(() {
      _isPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final HymnsUiPalette ui = context.hymnsPalette;
    final BorderRadius borderRadius = BorderRadius.circular(widget.radius);
    final Color resolvedColor = widget.color ?? ui.surface;
    final BorderSide resolvedBorderSide =
        widget.borderSide ?? BorderSide(color: ui.outline);

    return AnimatedScale(
      scale: widget.onTap != null && _isPressed ? 0.985 : 1,
      duration: const Duration(milliseconds: 140),
      curve: Curves.easeOutCubic,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: resolvedColor,
          borderRadius: borderRadius,
          border: Border.fromBorderSide(resolvedBorderSide),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ui.shadow,
              blurRadius: ui.isDark ? 18 : 24,
              offset: Offset(0, ui.isDark ? 8 : 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: widget.onTap,
            onTapDown: widget.onTap == null ? null : (_) => _setPressed(true),
            onTapCancel: widget.onTap == null ? null : () => _setPressed(false),
            onTapUp: widget.onTap == null ? null : (_) => _setPressed(false),
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class HymnsSectionPill extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;

  const HymnsSectionPill({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final HymnsUiPalette ui = context.hymnsPalette;
    final TextStyle? labelStyle = Theme.of(context).textTheme.labelMedium;
    final Color resolvedBackground = backgroundColor ?? ui.surfaceSecondary;
    final Color resolvedText = textColor ?? ui.textPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: resolvedBackground,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 14, color: resolvedText),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: labelStyle?.copyWith(
              color: resolvedText,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientOrb extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const _AmbientOrb({
    required this.size,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: colors),
        ),
      ),
    );
  }
}
