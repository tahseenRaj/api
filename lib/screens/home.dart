import 'package:api/services/user_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getUser(userName: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[200],
          title: TextField(
            style: const TextStyle(color: Colors.white),
            controller: searchController,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo)
              ),
              border: const UnderlineInputBorder(),
              hintText: 'Search by username',
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, color: Colors.grey[800],),
              // hintStyle: TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              setState(() {
                getUser(userName: searchController.text);
              });
            },
          ),
          elevation: 10,
        ),
        body: Column(
          children: [
            Flexible(
              child: FutureBuilder(
                future: searchController == ''
                    ? getUser()
                    : getUser(userName: searchController.text),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: Text(snapshot.data[index].id.toString()),
                            title: Text(snapshot.data[index].name),
                            subtitle: Text(snapshot.data[index].username),
                            trailing: Text(snapshot.data[index].phone),
                          );
                        }));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
    
                  // By default, show a loading spinner.
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
