import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_info/app/modules/home/external/heroku/heroku_api_datasource.dart';
import 'package:movies_info/app/modules/home/infra/models/movie_model.dart';

class DioMock extends Mock implements Dio {}

void main() {
  var dio = DioMock();
  var datasource = HerokuApiDatasource(dio);

  group('Verificação de sucesso:', () {
    test('deve retornar uma lista de MovieModel', () async {
      when(dio.get(any)).thenAnswer(
        (_) async => Response(
          data: jsonDecode(jResponse),
          statusCode: 200,
        ),
      );

      var response = await datasource.getMovies();

      expect(response, isA<List<MovieModel>>());
    });
  });
}

const jResponse = r'''{
  "filmes": [
    {
      "data": "24/03/1972", 
      "genero": "Policial, Drama", 
      "link": "http://www.adorocinema.com/filmes/filme-1628/", 
      "poster": "http://br.web.img3.acsta.net/medias/nmedia/18/90/93/20/20120876.jpg", 
      "sinopse": "Don Vito Corleone (Marlon Brando) \u00e9 o chefe de uma \"fam\u00edlia\" de Nova York que est\u00e1 feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo...", 
      "sinopseFull": "\nDon Vito Corleone (Marlon Brando) \u00e9 o chefe de uma \"fam\u00edlia\" de Nova York que est\u00e1 feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). Por\u00e9m, durante a festa, Bonasera (Salvatore Corsitto) \u00e9 visto no escrit\u00f3rio de Don Corleone pedindo \"justi\u00e7a\", vingan\u00e7a na verdade contra membros de uma quadrilha, que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, que maltrataram a filha de Bonasera n\u00e3o ser\u00e3o mortos, pois ela tamb\u00e9m n\u00e3o foi, mas ser\u00e3o severamente castigados. Vito por\u00e9m deixa claro que ele pode chamar Bonasera algum dia para devolver o \"favor\". Do lado de fora, no meio da festa, est\u00e1 o terceiro filho de Vito, Michael (Al Pacino), um capit\u00e3o da marinha muito decorado que h\u00e1 pouco voltou da 2\u00aa Guerra Mundial. Universit\u00e1rio educado, sens\u00edvel e perceptivo, ele quase n\u00e3o \u00e9 notado pela maioria dos presentes, com exce\u00e7\u00e3o de uma namorada da faculdade, Kay Adams (Diane Keaton), que n\u00e3o tem descend\u00eancia italiana mas que ele ama. Em contrapartida h\u00e1 algu\u00e9m que \u00e9 bem notado, Johnny Fontane (Al Martino), um cantor de baladas rom\u00e2nticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone j\u00e1 o tinha ajudado, quando Johnny ainda estava em come\u00e7o de carreira e estava preso por um contrato com o l\u00edder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o l\u00edder da banda e ofereceu 10 mil d\u00f3lares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga, e ap\u00f3s uma hora ele assinou a libera\u00e7\u00e3o por apenas mil d\u00f3lares, mas havia um detalhe: nas \"negocia\u00e7\u00f5es\" Luca colocou uma arma na cabe\u00e7a do l\u00edder da banda. Agora, no meio da alegria da festa, Johnny quer falar algo s\u00e9rio com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do est\u00fadio, Jack Woltz (John Marley), nem pensa em contrat\u00e1-lo. Nervoso, Johnny come\u00e7a a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguir\u00e1 o almejado papel. Enquanto a festa continua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo ter\u00e1 um emprego mas nada muito importante, e que os \"neg\u00f3cios\" n\u00e3o devem ser discutidos na sua frente. Os verdadeiros problemas come\u00e7am para Vito quando Sollozzo (Al Lettieri), um g\u00e2ngster que tem apoio de uma fam\u00edlia rival, encabe\u00e7ada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reuni\u00e3o com Vito, Sonny e outros, conta para a fam\u00edlia que ele pretende estabelecer um grande esquema de vendas de narc\u00f3ticos em Nova York, mas exige permiss\u00e3o e prote\u00e7\u00e3o pol\u00edtica de Vito para agir. Don Corleone odeia esta id\u00e9ia, pois est\u00e1 satisfeito em operar com jogo, mulheres e prote\u00e7\u00e3o, mas isto ser\u00e1 apenas a ponta do iceberg de uma mortal luta entre as \"fam\u00edlias\".\n", 
      "titulo": "O Poderoso Chef\u00e3o"
    }, 
    {
      "data": "01/05/2019", 
      "genero": "Hist\u00f3rico, Guerra", 
      "link": "http://www.adorocinema.com/filmes/filme-9393/", 
      "poster": "http://br.web.img2.acsta.net/pictures/19/04/10/19/44/2904073.jpg", 
      "sinopse": "A inusitada hist\u00f3ria de Oskar Schindler (Liam Neeson), um sujeito oportunista, sedutor, \"armador\", simp\u00e1tico, comerciante no mercado negro, mas,...", 
      "sinopseFull": "\n                      A inusitada hist\u00f3ria de Oskar Schindler (Liam Neeson), um sujeito oportunista, sedutor, \"armador\", simp\u00e1tico, comerciante no mercado negro, mas, acima de tudo, um homem que se relacionava muito bem com o regime nazista, tanto que era membro do pr\u00f3prio Partido Nazista (o que n\u00e3o o impediu de ser preso algumas vezes, mas sempre o libertavam rapidamente, em raz\u00e3o dos seus contatos). No entanto, apesar dos seus defeitos, ele amava o ser humano e assim fez o imposs\u00edvel, a ponto de perder a sua fortuna mas conseguir salvar mais de mil judeus dos campos de concentra\u00e7\u00e3o.\n        \n            ", 
      "titulo": "A Lista de Schindler"
    }, 
    {
      "data": "25/01/1995", 
      "genero": "Drama", 
      "link": "http://www.adorocinema.com/filmes/filme-11736/", 
      "poster": "http://br.web.img2.acsta.net/medias/nmedia/18/90/16/48/20083748.jpg", 
      "sinopse": "Em 1946, Andy Dufresne (Tim Robbins), um jovem e bem sucedido banqueiro, tem a sua vida radicalmente modificada ao ser condenado por um crime que...", 
      "sinopseFull": "\nEm 1946, Andy Dufresne (Tim Robbins), um jovem e bem sucedido banqueiro, tem a sua vida radicalmente modificada ao ser condenado por um crime que nunca cometeu, o homic\u00eddio de sua esposa e do amante dela. Ele \u00e9 mandado para uma pris\u00e3o que \u00e9 o pesadelo de qualquer detento, a Penitenci\u00e1ria Estadual de Shawshank, no Maine. L\u00e1 ele ir\u00e1 cumprir a pena perp\u00e9tua. Andy logo ser\u00e1 apresentado a Warden Norton (Bob Gunton), o corrupto e cruel agente penitenci\u00e1rio, que usa a B\u00edblia como arma de controle e ao Capit\u00e3o Byron Hadley (Clancy Brown) que trata os internos como animais. Andy faz amizade com Ellis Boyd Redding (Morgan Freeman), um prisioneiro que cumpre pena h\u00e1 20 anos e controla o mercado negro da institui\u00e7\u00e3o.\n", 
      "titulo": "Um Sonho de Liberdade"
    }
  ]
}''';
