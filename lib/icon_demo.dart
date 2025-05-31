import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'theme/app_theme.dart';
import 'assets/icon/app_icon.dart';

class IconDemoPage extends StatefulWidget {
  const IconDemoPage({Key? key}) : super(key: key);

  @override
  State<IconDemoPage> createState() => _IconDemoPageState();
}

class _IconDemoPageState extends State<IconDemoPage> {
  final GlobalKey _iconKey = GlobalKey();
  bool _isExporting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceA0,
      appBar: AppBar(
        title: const Text('Baloot Counter Icon'),
        backgroundColor: AppTheme.surfaceA10,
        foregroundColor: AppTheme.primaryA0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'App Icon Preview',
              style: TextStyle(
                color: AppTheme.primaryA0,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            // Display the icon with a RepaintBoundary for capturing
            RepaintBoundary(
              key: _iconKey,
              child: buildExportableIcon(size: 300),
            ),
            const SizedBox(height: 40),
            // Instructions and export button
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceA20,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How to use this icon:',
                    style: TextStyle(
                      color: AppTheme.primaryA0,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '1. Tap the button below to export the icon\n'
                    '2. Save the PNG image to your device\n'
                    '3. Use an icon generator tool to create icons for all platforms\n'
                    '4. Replace the default icons in your project',
                    style: TextStyle(
                      color: AppTheme.primaryA40,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isExporting ? null : _captureIcon,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryA0,
                        foregroundColor: AppTheme.surfaceA0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _isExporting ? 'Exporting...' : 'Export Icon',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to capture the icon as an image
  Future<void> _captureIcon() async {
    setState(() => _isExporting = true);
    
    try {
      // This is a placeholder for the actual image capture logic
      // In a real app, you would implement this to save the PNG
      
      // Get the RenderRepaintBoundary from the key
      final boundary = _iconKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      
      if (boundary != null) {
        // Capture the image
        final image = await boundary.toImage(pixelRatio: 3.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        
        if (byteData != null) {
          // In a real app, you would save this data to a file
          // or provide it for download
          
          // For this demo, we'll just show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Icon captured successfully! In a real app, this would save to a file.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to capture icon: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isExporting = false);
    }
  }
} 