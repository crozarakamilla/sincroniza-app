import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sincroniza/controllers/menu/menu_controller.dart';

part 'menu_repository.g.dart';

@Riverpod(keepAlive: true)
ScreenNameRepository screenNameRepository(Ref ref) {
  return ScreenNameRepository();
}

class ScreenNameRepository {
  ScreenNameRepository();

  String _currentScreen = '';

  void changeScreenName(String newScreen) {
    _currentScreen = newScreen;
  }

  String get currentScreen => _currentScreen;
}

@riverpod
MenuRepository menuRepository(Ref ref) {
  String screenName =
      ref.read(screenNameControllerProvider.notifier).currentScreenName();
  return MenuRepository(currentScreen: screenName);
}

class MenuRepository {
  MenuRepository({required this.currentScreen});

  final String currentScreen;

  List<PopupMenuEntry<String>> menuList() {
    switch (currentScreen) {
      case "events":
        return const [
          PopupMenuItem<String>(
            value: 'Novo Evento',
            child: Text('✏️ Novo Evento'),
          ),
          PopupMenuItem<String>(
            value: 'Configurações',
            child: Text('⚙️ Configurações'),
          ),
          PopupMenuItem<String>(
            value: 'Excluir',
            child: Text('🗑️ Excluir'),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(
                  width: 10,
                ),
                Text('Sair'),
              ],
            ),
          )
        ];
      case "groups":
        return const [
          PopupMenuItem<String>(
            value: 'Novo Naipe',
            child: Text('✏️ Novo Naipe'),
          ),
          PopupMenuItem<String>(
            value: 'Configurações',
            child: Text('⚙️ Configurações'),
          ),
          PopupMenuItem<String>(
            value: 'Excluir',
            child: Text('🗑️ Excluir'),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: Text('🗑️ Sair'),
          )
        ];
      case "calendar":
        return const [
          PopupMenuItem<String>(
            value: 'Calendário',
            child: Text('✏️ Calendário'),
          ),
          PopupMenuItem<String>(
            value: 'Configurações',
            child: Text('⚙️ Configurações'),
          ),
          PopupMenuItem<String>(
            value: 'Excluir',
            child: Text('🗑️ Excluir'),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: Text('🗑️ Sair'),
          )
        ];
      case "leaves":
        return const [
          PopupMenuItem<String>(
            value: 'Licenças',
            child: Text('✏️ Licenças'),
          ),
          PopupMenuItem<String>(
            value: 'Configurações',
            child: Text('⚙️ Configurações'),
          ),
          PopupMenuItem<String>(
            value: 'Excluir',
            child: Text('🗑️ Excluir'),
          ),
          PopupMenuItem<String>(
            value: 'logout',
            child: Text('🗑️ Sair'),
          )
        ];
    }
    return const [
      PopupMenuItem<String>(
        value: 'Editar Escalaçao',
        child: Text('✏️ Editar Escalação'),
      ),
      PopupMenuItem<String>(
        value: 'Configurações',
        child: Text('⚙️ Configurações'),
      ),
      PopupMenuItem<String>(
        value: 'Excluir',
        child: Text('🗑️ Excluir'),
      ),
      PopupMenuItem<String>(
        value: 'logout',
        child: Text('🗑️ Sair'),
      )
    ];
  }
}
