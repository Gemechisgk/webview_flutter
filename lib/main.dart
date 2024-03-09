import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Webview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController? controller;
  late bool isSubmitting = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Office'),
        centerTitle: true,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        //initialUrl: 'https://amazon.com',
        initialUrl: 'https://smartoffice.aalb.gov.et/admin',
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
        onPageStarted: (url) {
          // ignore: avoid_print
          print("New website: $url");
        },
        onPageFinished: (url) {
          if (isSubmitting) {
            controller?.loadUrl('https://smartoffice.aalb.gov.et/admin');
            isSubmitting = false;
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.import_export, size: 32),
        onPressed: () async {
          //below code for facebook url
          const email = 'Your Facebook Email';
          const password = 'Your Facebook Password';

          // ignore: deprecated_member_use
          controller?.evaluateJavascript(
              "document.getElementById('m_login_email').value='$email'");

          // ignore: deprecated_member_use
          controller?.evaluateJavascript(
              "document.getElementById('m_login_password').value='$password'");

          await Future.delayed(const Duration(seconds: 1));
          isSubmitting = true;
          // ignore: deprecated_member_use
          await controller?.evaluateJavascript('document.forms[0].submit()');

          //below code for amazon url..
          /* To hide header and footer of website
          // ignore: deprecated_member_use
          controller?.evaluateJavascript(
              "document.getElementsByTagName('header')[0].style.display='none'");
          // ignore: deprecated_member_use
          controller?.evaluateJavascript(
              "document.getElementsByTagName('footer')[0].style.display='none'");*/

          /* To show current url running...
           final url = await controller?.currentUrl();
           // ignore: avoid_print
           print('Previous Website: $url');*/

          /* to load new url using floatingactionbutton
          controller?.loadUrl('https://youtube.com');*/
        },
      ),
    );
  }
}
