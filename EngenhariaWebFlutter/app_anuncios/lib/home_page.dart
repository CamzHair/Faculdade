import 'package:flutter/material.dart';
import 'package:app_anuncios/model/anuncio.dart';
import 'package:app_anuncios/cadastro_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Anuncio> anuncios = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anúncios',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              Anuncio _anuncio = anuncios[index];
              return Dismissible(
                key: GlobalKey(),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      anuncios.removeAt(index);
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CadastroPage(),
                      ),
                    );
                  }
                },
                secondaryBackground: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment(0.9, 0.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                background: Container(
                  color: Colors.green,
                  child: const Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width * 16,
                  width: MediaQuery.of(context).size.width * 16,
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.newspaper,
                          size: 100,
                          color: Colors.deepOrange,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: [
                                Text(
                                  _anuncio.nome,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                Text(
                                  _anuncio.informacoes,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'R\$${_anuncio.preco}',
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),

                    /*child: ListTile(
                      leading: const Icon(
                        Icons.newspaper,
                        color: Colors.deepOrange,
                      ),
                      title: Text(_anuncio.nome),
                      subtitle: Text(_anuncio.informacoes),
                      trailing: Text(
                        'R\$${_anuncio.preco}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),*/
                  ),
                ),
              );
            },
            itemCount: anuncios.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Anuncio? anuncio = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPage()),
          );
          if (anuncio != null) {
            setState(() {
              anuncios.add(anuncio);
            });
          }
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
