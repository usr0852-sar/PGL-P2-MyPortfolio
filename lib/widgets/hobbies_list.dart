import 'package:flutter/material.dart';
import 'hobbie_box.dart';

class HobbiesList extends StatelessWidget {
    final List<String> hobbies = [
      "Ir al gimnasio",
      "Ver a Adrian en clase",
      "jugar a Isaac",
      "Ver al Tenerife",
      "los Videojuegos",
      "Domingos de jugarme un peak!",
      "La playita",
      "Escuchar música",
      "Hacer dinero (como don cangrejo)",
      "Por suerte también ducharme",
      "Ir a pasar tiempo con mi novia",
      "dormir",
    ]; // Perdón adrián pero lo dijiste tarde(ya te lo arreglé aqui, no me bajes nota porfa AJSJAJASJAS)

    HobbiesList({super.key});

    Widget _columna(List<String> items) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items
              .map((hobbies) => Padding( 
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: HobbiesBox(textasion: hobbies),
                  ))
              .toList(),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    final mitad = (hobbies.length / 2).ceil(); // Calcular el índice de la mitad de la lista para las columnas  
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _columna(hobbies.sublist(0, mitad)),
        const SizedBox(width: 15),
        _columna(hobbies.sublist(mitad)),
      ],
    );
  }
} 