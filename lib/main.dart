import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FitTrackProApp());
}

class FitTrackProApp extends StatelessWidget {
  const FitTrackProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack Pro',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const FitTrackWebView(),
    );
  }
}

class FitTrackWebView extends StatefulWidget {
  const FitTrackWebView({super.key});

  @override
  State<FitTrackWebView> createState() => _FitTrackWebViewState();
}

class _FitTrackWebViewState extends State<FitTrackWebView> {
  late final WebViewController controller;
  int progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            if (mounted) {
              setState(() {
                progress = value;
              });
            }
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://fittrack-pro-7993.ai.studio'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (progress < 100)
              LinearProgressIndicator(value: progress / 100),
          ],
        ),
      ),
    );
  }
}
