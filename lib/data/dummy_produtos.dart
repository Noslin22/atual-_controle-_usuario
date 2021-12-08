import 'package:atual_controle_usuario/models/produto.dart';

const DUMMY_PRODUTOS = {
  '1': const Produto(
      id: '1',
      nome: 'Mouse',
      quantidade: '3',
      valor: '33,50',
      descricao: 'Mouse Sem Fio 2.4 Ghz 1200 DPI Preto USB - Multilaser',
      status: 'Disponível',
      avatarUrls:
          'https://cdn.pixabay.com/photo/2016/04/12/13/20/mouse-1324375_960_720.jpg'),
  '2': const Produto(
      id: '2',
      nome: 'Fone de Ouvidos',
      quantidade: '0',
      valor: '75,99',
      descricao:
          'Headset Gamer Husky Gaming Polar, Preto, P2, Drivers 50mm, Rainbow - HGMD002',
      status: 'Indisponível',
      avatarUrls:
          'https://cdn.pixabay.com/photo/2018/09/17/14/27/headphones-3683983_960_720.jpg'),
  '3': const Produto(
      id: '3',
      nome: 'Hard Disk',
      quantidade: '7',
      valor: '220',
      descricao:
          'KIT HD Seagate BarraCuda, 1TB, 3.5´, SATA - ST1000DM010 + Cabo Husky Technologies, Preto, Sata, 18,5 cm',
      status: 'Disponível',
      avatarUrls:
          'https://cdn.pixabay.com/photo/2012/04/26/19/47/hard-disk-42935_960_720.png'),
  '4': const Produto(
      id: '4',
      nome: 'Caixa de Som',
      quantidade: '1',
      valor: '165,90',
      descricao: 'Caixa de Som Potente 200w Max Som ',
      status: 'Disponível',
      avatarUrls:
          'https://cdn.pixabay.com/photo/2019/02/11/05/48/speaker-3988833_960_720.png')
};
