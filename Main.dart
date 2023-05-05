Main.dart
import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;
  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Benedict Ramos', 'Encoder-MIS', '40 pesos/hr',
        'https://scontent.fmnl17-1.fna.fbcdn.net/v/t39.30808-6/323930831_1838956259836830_936065881593385819_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGczPkUSMa-CHeAbKxjhC-JwyInD-k4cXzDIicP6ThxfBtRz1-DTanJKcuHA9Gq3NZiaIm5eEY2E1RDrj8axkGl&_nc_ohc=cNOnCkeIYBgAX9IiaXR&_nc_ht=scontent.fmnl17-1.fna&oh=00_AfAOYLlY3rXmmINC9vn56OxoAa-aQgB1kEoAzpGXuuENUQ&oe=645896F5'),
    Person('Vic Sotto', 'Cashier-MIS', '50 pesos/hr',
        'https://media.philstar.com/photos/2022/02/24/vic_2022-02-24_16-49-21.jpg'),
    Person('Napoleon Hermoso', 'Analyst-MIS', '100 pesos/hr',
        'https://scontent.fmnl17-1.fna.fbcdn.net/v/t1.18169-9/10395814_959513914063548_4710304217051561344_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=8bfeb9&_nc_eui2=AeG5LpDvEQHoSc9KXmkyL-JxHlFGjoaNT30eUUaOho1PfSjMeC2GqaPrN2y8t6c4stu6JvIqVMZ4MXrx4BVeuH3I&_nc_ohc=dIPozdLZZNMAX_2ZfbW&_nc_ht=scontent.fmnl17-1.fna&oh=00_AfAPA82daDIRtJXfbQXuhOwreDZEZDCZkBfYUJLdVy8DMg&oe=647B4C77'),
    Person('Jackson Soriano', 'Manager', '140 pesos/hr',
        'https://i.pinimg.com/736x/16/51/61/165161fb0b30e2f62ba8f12900e80242.jpg'),
  ];
  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Benedict MIDTERM EXAM',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];
              return Card(
                color: Color(0xFFBDDFC9),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Position',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Rate:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  trailing: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Edit Profile"),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
