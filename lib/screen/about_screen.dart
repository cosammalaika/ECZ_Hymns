// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

// ignore: use_key_in_widget_constructors
class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF004d73),
        title: const Row(
          children: [
            Text(
              'About',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFFFF),
              ),
            ),
            Text(
              ' App',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w200,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SizedBox(
              height: 30,
              child: Image.asset(
                'assets/icons/share.png',
              ),
            ),
            onPressed: () {
              Share.share('com.creative_solutions.hymnalive');
            },
          ),
        ],
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppInfo(),
              // SizedBox(height: 10),
              CompanyInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/hymns.png',
          height: 70,
        ),
        const SizedBox(height: 10),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Hymns ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF004d73),
                ),
              ),
              TextSpan(
                text: 'Alive',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w200,
                  color: Color(0xFF004d73),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Version: 1.0.0',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w200,
            color: Color(0xFF000046),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFe6edf1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(
                20.0), // Added padding for the text container
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Hymns ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004d73),
                    ),
                  ),
                  TextSpan(
                    text:
                        'Alive, is a digital companion for spiritual upliftment through hymns and worship songs. This app brings a collection of timeless hymns to life in a modern, accessible format. Whether you\'re seeking solace, inspiration, or simply wish to enhance your worship experience, Hymns Alive provides a seamless platform to explore, engage, and immerse yourself in the rich tradition of hymnody',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFF000046),
                    ),
                  ),
                  TextSpan(
                    text: '\n\nDeveloped by: ',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                      color: Color(0xFF000046),
                    ),
                  ),
                  TextSpan(
                    text: 'C&J Creative Solution.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF004d73),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/company_logo.png',
          height: 200,
        ),
      ],
    );
  }
}
