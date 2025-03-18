import 'dart:math';

import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzy_bolt/fuzzy_bolt.dart' as fuzzy_bolt;

void main(List<String> arguments) {
  final query = arguments.join('');

  final levResults = fuzzyLev(query);
  final winkResults = fuzzyWink(query);

  print('your query $query \n');
  print('levenshtein | winkler \n');

  for (var i = 0; i < max(levResults.length, winkResults.length); i++) {
    print('${[(levResults[i]), (winkResults[i])].join(' | ')}\n');
  }
}

List<String> fuzzyLev(String query) =>
    extractAllSorted(
      query: query,
      choices: bibleBooks,
      cutoff: 0,
    ).map((item) => item.choice).toList();

List<String> fuzzyWink(String query) {
  final scoreMap =
      bibleBooks.map((book) {
          final score = fuzzy_bolt.jaroWinklerDistance(s1: book, s2: query);
          return <String, double>{book: score};
        }).toList()
        ..sort(
          (first, second) => second.values.first.compareTo(first.values.first),
        );

  return scoreMap.map((item) => item.keys.first).toList();
}

final List<String> bibleBooks = [
  // Old Testament
  "Genesis",
  "Exodus",
  "Leviticus",
  "Numbers",
  "Deuteronomy",
  "Joshua",
  "Judges",
  "Ruth",
  "1 Samuel",
  "2 Samuel",
  "1 Kings",
  "2 Kings",
  "1 Chronicles",
  "2 Chronicles",
  "Ezra",
  "Nehemiah",
  "Esther",
  "Job",
  "Psalms",
  "Proverbs",
  "Ecclesiastes",
  "Song of Solomon",
  "Isaiah",
  "Jeremiah",
  "Lamentations",
  "Ezekiel",
  "Daniel",
  "Hosea",
  "Joel",
  "Amos",
  "Obadiah",
  "Jonah",
  "Micah",
  "Nahum",
  "Habakkuk",
  "Zephaniah",
  "Haggai",
  "Zechariah",
  "Malachi",

  // New Testament
  "Matthew",
  "Mark",
  "Luke",
  "John",
  "Acts",
  "Romans",
  "1 Corinthians",
  "2 Corinthians",
  "Galatians",
  "Ephesians",
  "Philippians",
  "Colossians",
  "1 Thessalonians",
  "2 Thessalonians",
  "1 Timothy",
  "2 Timothy",
  "Titus",
  "Philemon",
  "Hebrews",
  "James",
  "1 Peter",
  "2 Peter",
  "1 John",
  "2 John",
  "3 John",
  "Jude",
  "Revelation",
];
