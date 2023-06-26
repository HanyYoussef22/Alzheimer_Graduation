import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alzahimer/Models/article_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'article_states.dart';

class ArticleCubit extends Cubit<ArticleStates> {
  ArticleCubit() : super(InitialState());

  static ArticleCubit get(context) => BlocProvider.of(context);

  List<ArticleModel> articles = [];
  void getArticles() {
    emit(GetArticlesLoadingState());
    FirebaseFirestore.instance.collection('articles').get().then((value) {
      emit(GetArticlesSuccessState());
      for (var element in value.docs) {
        articles.add(ArticleModel.fromJson(element.data()));
        print(articles[0].title);
      }
    }).catchError((e) {
      emit(GetArticlesErrorState());
      print(e.toString());
    });
  }
}
