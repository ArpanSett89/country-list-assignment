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
    final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/graphql');
    final ValueNotifier<GraphQLClient> clint = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,
          cache: GraphQLCache(store: InMemoryStore())
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
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
              final countryList = result.data?['countries'];
              print(countryList);
              return ListView.builder(
                itemCount: countryList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.black.withOpacity(0.2),
                        child: Text(countryList[index]['emoji'],
                          style: TextStyle(fontSize: 20),),
                      ),
                      title: Text(countryList[index]['name'],style: TextStyle(fontSize: 16),),
                       subtitle:Text(countryList[index]['native'],style: TextStyle(fontSize: 10),),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      tileColor: Colors.blue.withOpacity(0.1),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CountryDetails(
                            countryList: countryList[index],
                          ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            else{
              return Center(
                  child: CircularProgressIndicator(
                  value: null,
              )
              );
            }
          }
      ),
    );
  }
}