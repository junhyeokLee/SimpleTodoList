import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/todo_scroll_visibility_provider.dart';
import '../../utils/constants.dart';
import '../widgets/app_title.dart';

class AboutUsPage extends HookConsumerWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    void _launchUrl(Uri _url) async {
      await canLaunchUrl(_url)
          ? await launchUrl(_url)
          : throw 'Could not launch $_url';
    }

    return PopScope(
      onPopInvoked: (popDisposition) {
        updateScrollVisibility(ref, false);
      },
      child: Scaffold(
        appBar: AppBar(
          actions: const [
            Icon(Icons.ac_unit, color: Colors.transparent,),
            Icon(Icons.ac_unit, color: Colors.transparent,)
          ],
          title: const AppBarTitle(
            leadingTitle: 'About',
            trailingTitle: 'Us',
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                CarbonIcons.edit,
                size: 64,
              ),
              const SizedBox(
                height: 8,
              ),
              const AppBarTitle(
                trailingTitle: 'MemoPad',
                fontSize: 36,
              ),
              const AppBarTitle(
                leadingTitle: 'by',
                fontSize: 16,
              ),
              const SizedBox(
                height: 8,
              ),
              const AppBarTitle(
                trailingTitle: 'DevSheep',
                fontSize: 20,
              ),
              const SizedBox(
                height: 48,
              ),
              const Spacer(),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => _launchUrl(Uri.parse(mailUrl)),
                    icon: const Icon(
                      CarbonIcons.email,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _launchUrl(Uri.parse(githubUrl)),
                    icon: const Icon(
                      CarbonIcons.logo_github,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
