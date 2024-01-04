import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/game_model.dart';
import '../../repository/game_repository.dart';

// Events
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class FetchGames extends GameEvent {}

// States
abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameLoading extends GameState {}

class GameLoaded extends GameState {
  final List<Game> games;

  const GameLoaded(this.games);

  @override
  List<Object> get props => [games];
}

class GameError extends GameState {
  final String error;

  const GameError(this.error);

  @override
  List<Object> get props => [error];
}

// Cubit
class GameCubit extends Cubit<GameState> {
  final GameApiService gameApiService = GameApiService();

  GameCubit() : super(GameInitial());

  Future<void> fetchGames() async {
    try {
      emit(GameLoading());
      final List<Game> games = await gameApiService.fetchGameData();
      emit(GameLoaded(games));
    } catch (e) {
      emit(const GameError('Failed to fetch games'));
    }
  }
}
