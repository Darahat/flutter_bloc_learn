import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_learn/features/text/presentation/bloc/text_bloc.dart';
import 'package:flutter_bloc_learn/features/text/presentation/pages/text_page.dart';
import 'package:flutter_bloc_learn/core/hive_config.dart';
import 'package:flutter_bloc_learn/features/text/data/repositories/text_repository_impl.dart';
import 'package:flutter_bloc_learn/features/text/domain/usecases/save_text_usecase.dart';

void main() async {
  /// Ensure that the binding is initialized before using any Flutter widgets.
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();
  final repository = TextRepositoryImpl();
  final saveUseCase = SaveTextUsecase(repository);
  runApp(MyApp(repository: repository, saveUseCase: saveUseCase));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.saveUseCase, required this.repository});
  final TextRepositoryImpl repository;
  final SaveTextUsecase saveUseCase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TextBloc(saveUseCase, repository),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: TextPage()),
    );
  }
}

/// Root widget of the application
