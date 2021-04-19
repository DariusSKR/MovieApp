import 'package:flutter/material.dart';
import 'main.dart';
import 'model/movie.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();

  final List movies = [
    "Avatar",
    "I Am Legend",
    "300",
    "The Avengers",
    "The Wolf of Wall Street"
  ];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade100,
      ),
      backgroundColor: Colors.blueGrey.shade400,
      body: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: [
              Positioned(child: movieCard(movieList[index], context)),
              Positioned(
                  top: 10.0, child: movieImage(movieList[index].images[0]))
            ]);
            // return Card(
            //   elevation: 93.0,
            //   color: Colors.white,
            //   child: ListTile(
            //     leading: CircleAvatar(
            //       child: Container(
            //         width: 200,
            //         height: 200,
            //         decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: NetworkImage(movieList[index].images[0]),
            //               fit: BoxFit.cover
            //           ),
            //           color: Colors.blue,
            //           borderRadius: BorderRadius.circular(13.9),
            //         ),
            //         child: null,
            //       ),
            //     ),
            //     trailing: Text("..."),
            //     title: Text(movieList[index].title),
            //     subtitle: Text("${movieList[index].title}"),
            //     onTap: () {
            //       Navigator.push(context, MaterialPageRoute(
            //           builder: (context) =>
            //               MovieListViewDetails(movieName: movieList
            //                   .elementAt(index)
            //                   .title,
            //                 movie: movieList[index],)));
            //     },
            //     //     onTap: ()=> debugPrint("Movie name: ${movies.elementAt(index)}"),
            //   ),
            // );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext contex) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(contex).size.width,
        height: 120.0,
        child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(movie.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: Colors.white)),
                          ),
                          Text("Rating: ${movie.imdbRating}/10",
                              style: mainTextStyle())
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Released: ${movie.released}"),
                        Text(movie.runtime),
                        Text(movie.rated)
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
      onTap: () => {
        Navigator.push(
            contex,
            MaterialPageRoute(
                builder: (context) =>
                    MovieListViewDetails(movieName: movie.title, movie: movie)))
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(
      fontSize: 15.0,
      color: Colors.white,
    );
  }

  Widget movieImage(String imageUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl ??
                'https://upload.wikimedia.org/wikipedia/commons/b/be/KeizersgrachtReguliersgrachtAmsterdam.jpg'),
          )),
    );
  }
}

// ruta/pagina noua
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieListViewDetails({Key key, this.movieName, this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies ${this.movieName}"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          MovieHorizontalLine(),
          MovieDetailsCast(movie:movie),
          MovieHorizontalLine(),
          MovieDetailsExtraPoster(posters: movie.images,)
        ],
      ),
//      backgroundColor: Colors.blueGrey.shade900,
      // body: Center(
      //   child: Container(
      //       child: RaisedButton(
      //     child: Text("Go back ${this.movie.director}"),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   )
      //      ),
//      ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(thumbnail), fit: BoxFit.cover))),
            Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xa4eb34)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(poster: movie.images[0].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(child: (MovieDetailsHeader(movie: movie)))
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: 160,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(poster), fit: BoxFit.cover)),
          )),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie.year} . ${movie.genre}".toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie.title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
        Text.rich(TextSpan(
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            children: [
              TextSpan(text: movie.plot),
              TextSpan(text: "More...", style: TextStyle(color: Colors.cyan))
            ]))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors", value: movie.director)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;

  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field :",
          style: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}

class MovieHorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 0.5,
          color: Colors.grey,
      ),

    );
  }
}

class MovieDetailsExtraPoster extends StatelessWidget {
final List posters;

  const MovieDetailsExtraPoster({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("More movies posters".toUpperCase(),
    style: TextStyle(
    fontSize: 14,
    color:Colors.black26),
    ),
          Container(
            height: 200,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (contex, index)=>ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    width: MediaQuery.of(context).size.width/4,
                      height: 160,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(posters[index]),
                        fit:BoxFit.cover),
                      ),
                  ),
                ),
                separatorBuilder: (context, index)=> SizedBox(width: 8,),
                itemCount: posters.length),
          )
        ],
    );
  }
}
