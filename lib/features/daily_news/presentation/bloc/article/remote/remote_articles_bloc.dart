import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/core/resources/data_state.dart';
import 'package:news_feed/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_feed/features/daily_news/presentation/bloc/article/remote/remote_articles_event.dart';
import 'package:news_feed/features/daily_news/presentation/bloc/article/remote/remote_articles_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
    GetArticles event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    final dataState = await _getArticleUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticleDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticleFailed(dataState.error!));
    }
  }
}
