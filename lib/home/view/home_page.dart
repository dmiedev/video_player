import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/home/bloc/home_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  decoration:
                      const InputDecoration(hintText: 'Enter video URL...'),
                  validator: _validateVideoUrl,
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
    );
  }

  String? _validateVideoUrl(String? url) {
    if (url == null) {
      return null;
    } else if (!url.startsWith('https://')) {
      return 'This is not a HTTPS link!';
    }
    return null;
  }

  void _handleWatchButtonPress() {
    if (!_videoLinkFieldKey.currentState!.validate()) {
      return;
    }
    // context.read<HomeBloc>().add();
  }
}
