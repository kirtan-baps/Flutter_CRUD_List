import 'package:app_1/contact.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> contacts = List.empty(growable: true);

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: "Contact Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Contact Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String number = numberController.text.trim();
                        if (name.isNotEmpty && number.isNotEmpty) {
                          setState(() {
                            contacts.add(Contact(name: name, contact: number));
                            nameController.text = "";
                            numberController.text = "";
                          });
                        }
                      },
                      child: const Text("Save")),
                  ElevatedButton(
                      onPressed: () {
                        String name = nameController.text.trim();
                        String number = numberController.text.trim();
                        if (name.isNotEmpty && number.isNotEmpty) {
                          setState(() {
                            nameController.text = "";
                            numberController.text = "";
                            contacts[selectedIndex].name = name;
                            contacts[selectedIndex].contact = number;
                            selectedIndex = -1;
                          });
                        }
                      },
                      child: const Text("Update"))
                ],
              ),
              const SizedBox(height: 10),
              contacts.isEmpty
                  ? const Text(
                      "No Contacts",
                      style: TextStyle(fontSize: 22),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => getRow(index),
                        itemCount: contacts.length,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: index % 2 == 0 ? Colors.amber : Colors.red,
        child: Text(contacts[index].name[0]),
      ),
      title: Column(
        children: <Widget>[
          Text(contacts[index].name),
          Text(contacts[index].contact),
        ],
      ),
      trailing: SizedBox(
        width: 90,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  nameController.text = contacts[index].name;
                  numberController.text = contacts[index].contact;
                  setState(() {
                    selectedIndex = index;
                  });
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
