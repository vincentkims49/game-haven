// game_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/game_details_model.dart';
import '../../model/game_model.dart';
import '../../repository/game_repository.dart';

// Events
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class FetchGames extends GameEvent {}

class FetchGameDetails extends GameEvent {
  final String gameName;

  const FetchGameDetails(this.gameName);

  @override
  List<Object> get props => [gameName];
}

// States
abstract class GameState extends Equatable {
  const GameState();
}

class GameInitial extends GameState {
  @override
  List<Object> get props => [];
}

class GameLoading extends GameState {
  @override
  List<Object> get props => [];
}

class GameLoaded extends GameState {
  final List<Game> games;

  const GameLoaded(this.games);

  @override
  List<Object> get props => [games];
}

class GameDetailsLoading extends GameState {
  @override
  List<Object> get props => [];
}

class GameDetailsLoaded extends GameState {
  final GameSpecificDetails? gameDetails;

  const GameDetailsLoaded(this.gameDetails);

  @override
  List<Object> get props => [gameDetails ?? const Object()];
}

class GameError extends GameState {
  final String error;

  const GameError(this.error);

  @override
  List<Object> get props => [error];
}

// Cubit
class GameDetailsCubit extends Cubit<GameState> {
  final GameApiService gameApiService = GameApiService();

  GameDetailsCubit() : super(GameInitial());

  


  Future<GameSpecificDetails?> fetchGameDetails({required String gameName}) async {
    try {
      emit(GameDetailsLoading());
      final GameSpecificDetails? gameDetails =
          await gameApiService.fetchGameDetails(gameName: gameName);
      emit(GameDetailsLoaded(gameDetails));
      return gameDetails;
    } catch (e) {
      emit(GameError(e.toString()));
      return null;
    }
  }
}