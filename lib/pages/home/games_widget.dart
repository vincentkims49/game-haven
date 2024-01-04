import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_app/block/fetch_games/fetch_games_state_cubit.dart';
import 'package:game_app/pages/home/game_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GamesWidget extends StatelessWidget {
  const GamesWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        if (state is GameLoading) {
          return SliverFillRemaining(
            child: Center(
              child: LoadingAnimationWidget.halfTriangleDot(
                color: Colors.white,
                size: screenHeight * 0.03,
              ),
            ),
          );
        } else if (state is GameError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is GameLoaded) {
          final games = state.games;
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: screenWidth * 0.01,
              mainAxisSpacing: screenHeight * 0.01,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final game = games[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GameCard(
                      game: game,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight),
                );
              },
              childCount: games.length,
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: Center(
              child: Text('No games'),
            ),
          );
        }
      },
    );
  }
}
