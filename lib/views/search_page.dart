import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../services/apiDataSource_service.dart';
import '../views/detail_page.dart';
import '../models/search.dart';

class SearchPage extends StatefulWidget {
  final String cari;
  const SearchPage({Key? key, required this.cari}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<SearchData>>? _futureEvents;

  @override
  void initState() {
    super.initState();
    _futureEvents = fetchSearchEvents(widget.cari);
  }

  Future<List<SearchData>> fetchSearchEvents(String query) async {
    try {
      final response = await ApiDataSource.instance.loadSearchEvents(query);
      if (response.containsKey('data')) {
        List jsonResponse = response['data'];
        return jsonResponse.map((data) => SearchData.fromJson(data)).toList();
      } else {
        throw Exception('Data not found');
      }
    } catch (e) {
      throw Exception('Failed to load events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Hasil: ${widget.cari}',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildListEvents(),
    );
  }

  Widget _buildListEvents() {
    return Container(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List<SearchData>>(
        future: _futureEvents,
        builder:
            (BuildContext context, AsyncSnapshot<List<SearchData>> snapshot) {
          if (snapshot.hasError) {
            return _buildError(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return _buildSuccess(snapshot.data!);
            } else {
              return _buildNoData();
            }
          }
          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildError(Object? error) {
    return Center(
      child: Text("Error loading data: ${error.toString()}"),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Text("No events found."),
    );
  }

  Widget _buildSuccess(List<SearchData> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(data[index]);
      },
    );
  }

  Widget _buildItem(SearchData searchData) {
    return FadeInUp(
      duration: Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              slug: searchData.slug!,
              nama: searchData.nama!,
            ),
          ),
        ),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://api.yesplis.com/images/banner/${searchData.filename}',
                        ),
                        colorFilter: searchData.status != 1
                            ? ColorFilter.mode(
                                Colors.grey,
                                BlendMode.saturation,
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  searchData.nama ?? "No Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: searchData.status != 1 ? Colors.grey : Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  searchData.namaTempat ?? "No Place Name",
                  style: TextStyle(
                    fontSize: 16,
                    color: searchData.status != 1 ? Colors.grey : Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  searchData.alamat ?? "No Address",
                  style: TextStyle(
                    fontSize: 14,
                    color: searchData.status != 1 ? Colors.grey : Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  searchData.minprice != null
                      ? "Price: ${searchData.minprice}"
                      : "No Price",
                  style: TextStyle(
                    fontSize: 14,
                    color: searchData.status != 1 ? Colors.grey : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
