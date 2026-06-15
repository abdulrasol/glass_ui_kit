import 'package:flutter/material.dart';
import 'button.dart';

/// Async button that auto-manages loading and error states.
///
/// Wraps [Button] with a loading indicator and error SnackBar.
class SubmitButton extends StatefulWidget {
  /// Text displayed on the button.
  final String label;

  /// Async callback invoked when the button is pressed.
  final Future<void> Function() onPressed;

  /// Optional background color for the button.
  final Color? backgroundColor;

  /// Corner radius of the button shape.
  final double borderRadius;

  /// Creates a [SubmitButton] that shows a loading indicator while [onPressed]
  /// is in-flight and displays a SnackBar on error.
  ///
  /// [label] and [onPressed] are required.
  const SubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius = 8,
  });

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _isLoading = false;

  Future<void> _handlePressed() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      label: widget.label,
      onClick: _handlePressed,
      isLoading: _isLoading,
      borderRadius: widget.borderRadius,
      backgroundColor: widget.backgroundColor,
    );
  }
}