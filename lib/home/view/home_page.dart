import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/home/bloc/home_bloc.dart';
import 'package:video_player/player/view/player_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _videoLinkFieldKey = GlobalKey<FormFieldState<String>>();
  final _videoLinkFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: _handleHomeStateChange,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Video Player',
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    key: _videoLinkFieldKey,
                    controller: _videoLinkFieldController,
                    decoration:
                        const InputDecoration(hintText: 'Enter video URL...'),
                    validator: _validateVideoLink,
                  ),
                ),
                const SizedBox(height: 30),
                FloatingActionButton.extended(
                  label: const Text('WATCH'),
                  onPressed: _handleWatchButtonPress,
                ),
                const SizedBox(height: 50),
                const Text('Note: Video Player only supports HTTPS links.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateVideoLink(String? link) {
    if (link == null) {
      return null;
    } else if (!link.startsWith('https://') || !Uri.parse(link).isAbsolute) {
      return 'This is not a valid HTTPS link!';
    }
    return null;
  }

  void _handleWatchButtonPress() {
    if (!_videoLinkFieldKey.currentState!.validate()) {
      return;
    }
    context.read<HomeBloc>().add(
          HomeVideoLinkEntered(
            videoLink: _videoLinkFieldController.text,
          ),
        );
  }

  void _handleHomeStateChange(BuildContext context, HomeState state) {
    Navigator.push(
      context,
      PlayerPage.getRoute(videoLink: state.videoLink),
    );
  }

  @override
  void dispose() {
    _videoLinkFieldController.dispose();
    super.dispose();
  }
}
