String alzheimersHistory =
    '''Alzheimer's disease is a devastating condition that affects millions of people worldwide. It is a progressive neurodegenerative disorder that gradually destroys a person's memory and cognitive abilities. Despite being such a well-known condition, the history and discovery of Alzheimer's disease are relatively recent.

The first case of what we now know as Alzheimer's disease was described by Dr. Alois Alzheimer in 1906. Dr. Alzheimer was a German psychiatrist and neuropathologist who was studying a patient named Auguste Deter. Auguste was a 51-year-old woman who had been suffering from memory loss and other cognitive problems for several years. Dr. Alzheimer examined Auguste's brain after she died and found unusual clumps and tangles of protein in her brain tissue. These clumps and tangles are now known as amyloid plaques and neurofibrillary tangles, respectively, and are considered to be hallmark features of Alzheimer's disease.

Following his discovery, Dr. Alzheimer published a paper in which he described the pathological features of Auguste's brain. He called the condition 'presenile dementia,' which was later changed to Alzheimer's disease in his honor. Despite Dr. Alzheimer's groundbreaking discovery, it wasn't until several decades later that the condition became widely recognized and studied.

In the 1970s and 1980s, researchers began to focus more on Alzheimer's disease and its underlying causes. It was during this time that the amyloid hypothesis was proposed. This hypothesis suggests that the accumulation of amyloid plaques in the brain is the primary cause of Alzheimer's disease. Since then, many researchers have focused their efforts on developing drugs that can target and reduce amyloid accumulation in the brain.

In the years since Dr. Alzheimer's initial discovery, we have learned a great deal about the condition. We now know that Alzheimer's disease is the most common cause of dementia, affecting millions of people worldwide. We also know that the condition is caused by a complex interplay of genetic and environmental factors, and that there are several different subtypes of the condition.

Despite our increased understanding of Alzheimer's disease, there is still much that we don't know about the condition. There is currently no cure for Alzheimer's disease, and existing treatments can only help manage symptoms. However, ongoing research continues to shed light on the underlying causes of the condition, and many scientists remain optimistic that effective treatments and even a cure may be possible in the future.''';

String title =
    "World Alzheimer's Day: Raising Awareness and Support for a Devastating Disease.";
String subtitle =
    "Know Dementia, Know Alzheimer's: Join the Global Movement on World Alzheimer's Day.";

class ArticleModel {
  String? title;
  String? content;
  String? imageUrl;
  String? date;
  String? author;

  ArticleModel(
      {required this.title,
      required this.content,
      required this.imageUrl,
      required this.date,
      required this.author});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json["title"],
      content: json["content"],
      imageUrl: json["image"],
      date: json["date"],
      author: json["author"],
    );
  }
}
