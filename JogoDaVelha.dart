import 'dart:io';
import 'dart:math';

void main() {
  List<String> tabela = [
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
    " ",
  ];
  bool playerW = false;
  bool pcW = false;
  bool empate = false;
  Random num = Random();
  int temp = -1;
  int coord = -1;

  while (!playerW && !pcW && !empate) {
    printTabela(tabela);
    print("");

    while ((coord < 0 || coord > 8) || tabela[coord] != " ") {
      print("Digite aonde jogar: ");
      coord = mapearControles(stdin.readLineSync()!);
      // Null Safety
      // ! no fim significa que o resultado apesar de poder retornar null, não vai(Como o compilador enxerga);
      // ?? "ret" -> se colocasse isso no lugar da exclamação, caso a entrada fosse null coord receberia "ret"
      // Se int coord? -> aceita null;
    }

    tabela[coord] = "X";
    coord = -1;
    playerW = verificarGanhador(tabela);

    if (!(listaCheia(tabela) && playerW)) {
      while (temp == -1 || tabela[temp] != " ") {
        temp = num.nextInt(9);
      }

      tabela[temp] = "O";
      temp = -1;
      pcW = verificarGanhador(tabela);
    } else if (!playerW && !pcW) {
      empate = true;
      print("Empate!");
    }
  }

  if (playerW) {
    print("Você ganhou!");
  } else if (pcW) {
    print("Você perdeu!");
  }
  printTabela(tabela);
}

bool listaCheia(List<String> tabela) {
  for (int i = 0; i <= 8; i++) {
    if (tabela[i] == " ") {
      return false;
    }
  }
  return true;
}

bool verificarGanhador(List<String> tabela) {
  for (int i = 0; i < 7; i++) {
    if (tabela[i] != " " &&
        tabela[i + 1] == tabela[i] &&
        tabela[i + 2] == tabela[i]) {
      return true;
    }
    i += 2;
  }
  for (int i = 0; i < 3; i++) {
    if (tabela[i] != " " &&
        tabela[i + 3] == tabela[i] &&
        tabela[i + 6] == tabela[i]) {
      return true;
    }
  }
  if (tabela[0] != " " && tabela[4] == tabela[0] && tabela[8] == tabela[0]) {
    return true;
  }
  if (tabela[2] != " " && tabela[4] == tabela[2] && tabela[6] == tabela[2]) {
    return true;
  }
  return false;
}

void printTabela(List<String> tabela) {
  print("----------");
  for (int i = 0; i < 7; i++) {
    print(tabela[i] + " | " + tabela[i + 1] + " | " + tabela[i + 2]);
    print("----------");
    i += 2;
  }
}

int mapearControles(String entrada) {
  switch (entrada) {
    case '1':
      return 6;
    case '2':
      return 7;
    case '3':
      return 8;
    case '4':
      return 3;
    case '5':
      return 4;
    case '6':
      return 5;
    case '7':
      return 0;
    case '8':
      return 1;
    case '9':
      return 2;
    default:
      return -1;
  }
}
