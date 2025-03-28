# hotel-pets

## Sobre

Um sistema para gerenciar um hotel de pets. Gerencie tutores, os animais e suas estadias no hotel. O sistema, desenvolvido com Flutter (no frontend) e Nodejs (no backend), permite que o usuário gerencie as estadias de animais no hotel, controlando diversas estadias por animal e diversos animais por tutor. As estadias ficam, além do histórico, na tela inicial como estadias ativas (acontecendo) e estadias pendentes (vão acontecer) e não precisam de data de saída. Além disso, um animal não pode ter duas estadias conflitantes (em relação às diárias).

## Configuração

Instalados o flutter e o nodejs, configure o arquivo database.js localizado em 'hotel-pets\hotel-back\src\config\database.js' com as variáveis do seu ambiente de desenvolvimento. Crie o banco de dados (postgresql) chamado 'hoteldb'.