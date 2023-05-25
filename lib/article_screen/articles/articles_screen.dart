
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../article_cubit.dart';
import '../article_states.dart';

class ArticleScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return BlocProvider(
      create: (context)=>ArticleCubit()..getArticles(),
        child: BlocConsumer<ArticleCubit,ArticleStates>(
          builder: (context,state){
            ArticleCubit cubit = BlocProvider.of(context);
            return Scaffold(
              body: ListView.builder(
                itemCount: cubit.articles.length,
                itemBuilder: (context, index) {
                  return newsWidget(
                    author: cubit.articles[index].author!,
                    onTap: (){
                      Navigator.pushNamed(context, '/article_details_screen',
                      arguments: cubit.articles[index],
                      );
                    },
                      context: context,
                      title:
                      cubit.articles[index].title!,
                      articleDate: cubit.articles[index].date!,
                      img:
                      cubit.articles[index].imageUrl!);
                },
              ),
            );
          },
          listener: (context,state){

          },
        ),
    );
  }
  newsWidget({
    required BuildContext context,
    required String img,
    required String articleDate,
    required String title,
    required String author,
    required onTap
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 22,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'janna',
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline_outlined, color: Colors.purple.withOpacity(0.5),),
                            const SizedBox(width: 8,),
                            Text(
                              author,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6,),
                        Row(
                          children: [
                             Icon(Icons.calendar_today,
                            color: Colors.purple.withOpacity(0.5),
                            ),
                            const SizedBox(width: 8,),
                            Text(
                              articleDate,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
