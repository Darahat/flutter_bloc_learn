import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Importing the parts for event and state definitions
part 'home_event.dart';
part 'home_state.dart';

// The HomeBloc class extends Bloc and manages the state of the application
class HomeBloc extends Bloc<HomeEvent, CounterState> {
  // Constructor initializes the bloc with an initial state
  HomeBloc() : super(CounterState(counter: 1)) {
    // Specific event handler for CounterIncrementPressed
    on<CounterIncrementPressed>((event, emit) {
      // Emits a new CounterState with the incremented counter value
      emit(CounterState(counter: event.counter + 1));
    });
  }
}
