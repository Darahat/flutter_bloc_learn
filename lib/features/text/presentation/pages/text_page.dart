import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/features/text/presentation/bloc/text_bloc.dart';

class TextPage extends StatelessWidget {
  TextPage({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Saver')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: controller),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                final input = controller.text.trim();
                if (input.isNotEmpty) {
                  context.read<TextBloc>().add(AddTextEvent(input));
                  controller.clear();
                }
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<TextBloc, TextState>(
                builder: (context, state) => switch (state) {
                  TextInitial() => const CircularProgressIndicator(),
                  TextLoaded(:final entries) => ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(entries[index]));
                    },
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
