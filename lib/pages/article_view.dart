import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({super.key, required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller WebView
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFFFFFFF))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            // progress loading (0 - 100)
          },
          onPageStarted: (url) {
            debugPrint('Started: $url');
          },
          onPageFinished: (url) {
            debugPrint('Finished: $url');
          },
          onWebResourceError: (error) {
            debugPrint('Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.blogUrl));

    // Android-specific feature (opsional)
    if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      AndroidWebViewController.enableDebugging(true);
      (WebViewPlatform.instance as AndroidWebViewPlatform)
              .useHybridComposition =
          true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News Details',
          style: TextStyle(fontSize: 20.5, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

extension on AndroidWebViewPlatform {
  set useHybridComposition(bool useHybridComposition) {}
}
