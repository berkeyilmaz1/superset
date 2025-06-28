import 'package:flutter/material.dart';
import 'package:superset/core/constants/app_padings.dart';
import 'package:superset/core/constants/border_radius_general.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    required this.onPressed,
    required this.buttonText,
    super.key,
    this.isEnabled = true,
    this.isLoading = false,
    this.icon,
    this.variant = ButtonVariant.primary,
  });

  final VoidCallback onPressed;
  final String buttonText;
  final bool isEnabled;
  final bool isLoading;
  final IconData? icon;
  final ButtonVariant variant;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

enum ButtonVariant { primary, secondary, outline, danger }

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(
          begin: 1,
          end: 0.95,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return Colors.blue.shade600;
      case ButtonVariant.secondary:
        return Colors.grey.shade200;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.danger:
        return Colors.red.shade600;
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.danger:
        return Colors.white;
      case ButtonVariant.secondary:
        return Colors.grey.shade800;
      case ButtonVariant.outline:
        return Colors.blue.shade600;
    }
  }

  List<BoxShadow> _getShadows() {
    if (widget.variant == ButtonVariant.outline) return [];

    return [
      BoxShadow(
        color: _getBackgroundColor().withOpacity(0.3),
        blurRadius: _isPressed ? 4 : 8,
        offset: Offset(0, _isPressed ? 2 : 4),
      ),
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: _isPressed ? 2 : 4,
        offset: Offset(0, _isPressed ? 1 : 2),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              if (widget.isEnabled && !widget.isLoading) {
                setState(() => _isPressed = true);
                _animationController.forward();
              }
            },
            onTapUp: (_) {
              if (widget.isEnabled && !widget.isLoading) {
                setState(() => _isPressed = false);
                _animationController.reverse();
                widget.onPressed();
              }
            },
            onTapCancel: () {
              setState(() => _isPressed = false);
              _animationController.reverse();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                gradient: widget.variant == ButtonVariant.primary
                    ? LinearGradient(
                        colors: [
                          Colors.blue.shade500,
                          Colors.blue.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : widget.variant == ButtonVariant.danger
                    ? LinearGradient(
                        colors: [
                          Colors.red.shade500,
                          Colors.red.shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color:
                    widget.variant == ButtonVariant.primary ||
                        widget.variant == ButtonVariant.danger
                    ? null
                    : _getBackgroundColor(),
                borderRadius: const BorderRadiusGeneral.allSmall(),
                border: widget.variant == ButtonVariant.outline
                    ? Border.all(
                        color: Colors.blue.shade600,
                        width: 2,
                      )
                    : null,
                boxShadow: widget.isEnabled ? _getShadows() : [],
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const AppPaddings.buttonPadding(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isLoading) ...[
                        SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getTextColor(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ] else if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 18,
                          color: _getTextColor(),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.buttonText,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: widget.isEnabled
                              ? _getTextColor()
                              : _getTextColor().withOpacity(0.5),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
