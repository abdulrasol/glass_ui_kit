import 'package:flutter/material.dart';
import 'package:glass_ui_kit/glass_ui_kit.dart';

void main() {
  runApp(const GlassExampleApp());
}

class GlassExampleApp extends StatelessWidget {
  const GlassExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass UI Kit Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        extensions: [
          GlassThemeTokens.greenTheme(brightness: Brightness.light),
        ],
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        extensions: [
          GlassThemeTokens.greenTheme(brightness: Brightness.dark),
        ],
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = TextEditingController();
  String _selectedChip = 'Option A';
  bool _isChecked = false;
  TimeOfDay? _selectedTime;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: 'Glass UI Kit',
      builder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.only(top: topPadding + 8, left: 8, right: 8, bottom: 32),
          children: [
            const SizedBox(height: 8),
            Text(
              'GlassContainer Variants',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            _VariantShowcase(),
            const SizedBox(height: 24),
            Text(
              'Buttons',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            Button(label: 'Primary Button', onClick: () {}),
            const SizedBox(height: 12),
            Button(label: 'Secondary Button', variant: GlassButtonVariant.secondary, onClick: () {}),
            const SizedBox(height: 12),
            Button(label: 'Disabled', enabled: false),
            const SizedBox(height: 24),
            Text(
              'Form Inputs',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextInputField(
              label: 'Plant Name',
              controller: _textController,
              hintText: 'Enter a name...',
              icon: Icons.local_florist,
            ),
            const SizedBox(height: 16),
            CheckboxField(
              label: 'Water daily',
              initialValue: _isChecked,
              onChanged: (value) => setState(() => _isChecked = value),
            ),
            const SizedBox(height: 16),
            TimePickerField(
              label: 'Watering Time',
              onTimeSelected: (time) => setState(() => _selectedTime = time),
              initialTime: _selectedTime,
            ),
            const SizedBox(height: 16),
            GlassSegmentedChipsPicker<String>(
              label: 'Category',
              value: _selectedChip,
              items: const [
                GlassSegmentedChipsItem(value: 'Option A', label: 'A'),
                GlassSegmentedChipsItem(value: 'Option B', label: 'B'),
                GlassSegmentedChipsItem(value: 'Option C', label: 'C'),
              ],
              onChanged: (value) => setState(() => _selectedChip = value),
            ),
            const SizedBox(height: 24),
            Text(
              'Loading Indicator',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            const Center(child: GlassPulsingIndicator(size: 64)),
          ],
        );
      },
    );
  }
}

class _VariantShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassContainer(
          variant: GlassSurfaceVariant.primary,
          borderRadius: 20,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Primary Surface'),
          ),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          variant: GlassSurfaceVariant.secondary,
          borderRadius: 20,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Secondary Surface'),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlassContainer(
              variant: GlassSurfaceVariant.circular,
              child: IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}