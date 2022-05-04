import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'countrydetails.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink('https://countries.trevorblades.com/graphql');
    final ValueNotifier<GraphQLClient> clint = ValueNotifier<GraphQLClient>(
      GraphQLClient(
          link: httpLink, cache: GraphQLCache(store: InMemoryStore())),
    );
    return GraphQLProvider(
      child: Body2(),
      client: clint,
    );
  }
}

class Body2 extends StatefulWidget {
  const Body2({Key? key}) : super(key: key);

  @override
  State<Body2> createState() => Body2State();
}

class Body2State extends State<Body2> {
  List<dynamic> countryList = [];
  List<dynamic> countryList1 = [];
  TextEditingController value1TEC = TextEditingController();
 /* onItemChanged(String value) {
    for (var i =0;i<countryList.length;i++)
      {
        /*if(countryList[i]['name'].toString()==value1TEC.toString())
          {
            print(countryList[i]['name']);
          }*/
        countryList1[i]['name'] =countryList.where((element) => element[i]['name']==countryList[i]['name'],);
      }

  }*/
  onItemChanged(String value) {
    setState(() {
      for (var i=0;i<countryList.length;i++)
      {

        if(countryList[i]['name'].toString().toLowerCase() == value1TEC.text.toLowerCase())
          {
            print(value1TEC.text.toLowerCase());
            countryList1[i]=countryList[i];
          }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                //onChanged: onItemChanged,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){onItemChanged(value1TEC.text);},
                      icon: Icon(Icons.search)),
                  label: Text(
                    'Search',
                    style: TextStyle(fontSize: 10, color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(33),
                  )),
                ),
                cursorHeight: 25,
                controller: value1TEC,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Container(
              alignment: Alignment.topCenter,
              child: Query(
                  options: QueryOptions(document: gql("""query Query {
  countries{
                name
                native
                capital
                emoji
                currency
                languages {
                  code
                  name
                }
  }
}""")),
                  builder: (QueryResult result,
                      {VoidCallback? refetch, FetchMore? fetchMore}) {
                    if (result.data != null) {
                      countryList = result.data?['countries'];
                      print(countryList);
                      return ListView.builder(
                        itemCount: countryList1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.2),
                                child: Text(
                                  countryList1[index]['emoji'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              title: Text(
                                countryList1[index]['name'],
                                style: TextStyle(fontSize: 16),
                              ),
                              subtitle: Text(
                                countryList1[index]['native'],
                                style: TextStyle(fontSize: 10),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetails(
                                      countryList: countryList1[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      );
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        value: null,
                      ));
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
