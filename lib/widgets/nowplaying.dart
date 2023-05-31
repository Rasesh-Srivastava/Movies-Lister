import 'package:flutter/material.dart';
import 'package:final_movie/utils/text.dart';

import '../description.dart';

class NowPlaying extends StatelessWidget {
  final List nowPlaying;

  const NowPlaying({Key? key, required this.nowPlaying}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const modified_text(
            text: 'Now Playing',
            size: 26,
          ),
          const SizedBox(height: 10),
          Container(
            // color: Colors.red,
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: nowPlaying.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                name: nowPlaying[index]['title'],
                                bannerurl:
                                'https://image.tmdb.org/t/p/w500' +
                                    nowPlaying[index]['backdrop_path'],
                                posterurl:
                                'https://image.tmdb.org/t/p/w500' +
                                    nowPlaying[index]['poster_path'],
                                description: nowPlaying[index]['overview'],
                                vote: nowPlaying[index]['vote_average']
                                    .toString(),
                                launch_on: nowPlaying[index]
                                ['release_date'],
                              )));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      // color: Colors.green,
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(

                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          nowPlaying[index]['poster_path']),
                                  ),
                            ),
                            height: 200,
                          ),
                          SizedBox(height: 5),
                          Flexible(
                            child: Container(
                              child: modified_text(
                                  size: 15,
                                  text: nowPlaying[index]['original_title'] ?? 'Loading'),
                            ),
                          )
                        ],
                      ),
                    )
                    );
                  }))
        ],
      ),
    );
  }
}