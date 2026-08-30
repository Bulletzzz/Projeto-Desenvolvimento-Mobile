import 'package:flutter/widgets.dart';

class LogoBalancete extends StatelessWidget {
	const LogoBalancete({super.key, required this.altura});

	final double altura;

	@override
	Widget build(BuildContext context) {
		return SizedBox(
			height: altura,
			child: DecoratedBox(
				decoration: BoxDecoration(
					shape: BoxShape.circle,
					gradient: LinearGradient(
						colors: [const Color(0xFF0A57C2), const Color(0xFF3F8CF3)],
						begin: Alignment.topLeft,
						end: Alignment.bottomRight,
					),
				),
				child: Center(
					child: Text(
						'B',
						style: TextStyle(
							color: const Color(0xFFFFFFFF),
							fontWeight: FontWeight.bold,
							fontSize: altura * 0.5,
						),
					),
				),
			),
		);
	}
}
