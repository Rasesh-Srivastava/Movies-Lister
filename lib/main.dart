import 'package:final_movie/utils/text.dart';
import 'package:final_movie/widgets/nowplaying.dart';
import 'package:final_movie/widgets/toprated.dart';
import 'package:final_movie/widgets/trending.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
      primaryColor: Colors.green
      ),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovies =[];
  List topRatedMovies = [];
  List nowPlaying = [];
  final String apiKey ='30c1452fae9a87aa0edf3bf16e0f69a5';
  final String readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMGMxNDUyZmFlOWE4N2FhMGVkZjNiZjE2ZTBmNjlhNSIsInN1YiI6IjYzZGJhN2Y2M2RjMzEzMDBjN2ZjMGRkYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KOFQOUsn5EY_TF9Qc9eI2Th812YE_qx-R-wZLPyfOHM';
  @override
  void initState(){
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey,readAccessToken),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
    );
    Map trendingResult = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map topRatedResult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map nowPlayingResult = await tmdbWithCustomLogs.v3.movies.getNowPlaying();

    // print(trendingResult);
    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResult['results'];
      nowPlaying = nowPlayingResult['results'];
    });
    // print(trendingMovies);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const modified_text(text: 'Movies App ❤',size: 24,),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          TrendingMovies(trending: trendingMovies),
          TopRatedMovies(toprated: topRatedMovies),
          NowPlaying(nowPlaying: nowPlaying),
        ],
      ),
    );
  }
}


