import 'package:flutter/material.dart';
import 'hobbie_box.dart';

class HobbiesList extends StatelessWidget {
  final List<String> hobbies = [
    "Ir al gimnasio",
    'Ver a Adrian en clase',
    'jugar a Isaac',
    'Ver al Tenerife',
    "Escuchar música",
    "Hacer dinero (como don cangrejo)",
  ];

  HobbiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HobbiesBox(textasion: hobbies[0]),
              const SizedBox(height: 10),
              HobbiesBox(textasion: hobbies[1]),
              const SizedBox(height: 10),
              HobbiesBox(textasion: hobbies[2]),
              const SizedBox(height: 10),
              HobbiesBox(textasion: hobbies[3]),
              const SizedBox(height: 10),
              const HobbiesBox(textasion: "los Videojuegos"),
              const SizedBox(height: 10),
              const HobbiesBox(textasion: "Domingos de jugarme un peak!"),
            ],
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const HobbiesBox(textasion: "La playita"),
              const SizedBox(height: 10),
              HobbiesBox(textasion: hobbies[4]),
              const SizedBox(height: 10),
              HobbiesBox(textasion: hobbies[5]),
              const SizedBox(height: 10),
              const HobbiesBox(textasion: "Por suerte también ducharme"),
              const SizedBox(height: 10),
              const HobbiesBox(textasion: "Ir a pasar tiempo con mi novia"),
              const SizedBox(height: 10),
              const HobbiesBox(textasion: "dormir"),
            ],
          ),
        ),
      ],
    );
  }
}