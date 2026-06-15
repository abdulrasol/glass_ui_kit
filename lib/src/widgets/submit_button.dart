import 'package:flutter/material.dart';
import 'button.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final Future<void> Function() onPressed;
  final Color? backgroundColor;
  final double borderRadius;

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