# Rails Seed

## Instalación y ejecución para desarrollo en OS X

El entorno de desarrollo está aislado y autocontenido por medio de contenedores, por lo cual es necesario instalar [Docker](https://www.google.com/search?q=install+docker+os+x).

En primer lugar se debe definir un archivo con variables de configuración. Es posible utilizar uno de ejemplo:

  ```
  $ cp .env.dev.sample .env
  ```

Para construir la imagen docker del proyecto ejecutar:

  ```
  $ make build
  ```

Luego, para levantar los contenedores se debe ejecutar el siguiente comando:

  ```
  $ make run # también es posible usar 'make start' para ejecutar en background
  ```

Cuando el comando ***make run*** es ejecutado por primera vez, realiza la instalación de gemas y paquetes bower del proyecto. La instalación de todo lo mencionado habrá finalizado cuando aparezca el siguiente mensaje en la consola:

  ```
  $ ################################
  $ #                              #
  $ #                              #
  $ #    OPS CONTAINER IS READY    #
  $ #                              #
  $ #                              #
  $ ################################
  ```

Una vez que los contenedores están ejecutándose, es posible encontrar a cualquiera de ellos con alguno de los siguientes comandos (ejecutar en otra pestaña):

  ```
  $ make enter # ingresa al contenedor Rails
  $ make enter-sidekiq # ingresa al contenedor Sidekiq
  $ make enter-ops # ingresa al contenedor de DevOps
  ```

Para configurar el proyecto por primera vez, entrar a un contenedor rails y ejecutar:

  ```
  $ make init
  ```

Para levantar el servidor de desarrollo Rails se debe entrar en dicho contenedor y ejecutar:

  ```
  $ make server # o 'make s'
  ```

Para probar el scaffolding, dentro del contenedor rails ejecutar:

  ```
  $ make redo
  ```

Una vez finalizado el scaffolding se puede visitar algunos de los recursos creados, por ejemplo: [http://localhost:3000/countries](http://localhost:3000/countries)


### Comandos para desarrollo
  - (host) ***make build***: Construye las imágenes docker para cada servicio
  - (host) ***make run***: Crea los contenedores para cada servicio
  - (host) ***make start***: Similar a ***make run*** pero opera en background
  - (host) ***make stop***: Detiene los contenedores en ejecución
  - (host) ***make enter***: Ingresa al contenedor Rails
  - (host) ***make enter-sidekiq***: Ingresa al contenedor Sidekiq
  - (host) ***make enter-ops***: Ingresa al contenedor de DevOps
  - (contenedor rails) ***make init***: Ajusta el proyecto para comenzar a desarrollar
  - (contenedor rails) ***make server***: Inicia el servidor Webrick. También es posible con el comando ***make s***
  - (contenedor rails) ***make redo***: Inicia el scaffolding definido en el makefile
  - (contenedor sidekiq) ***make sidekiq***: Inicia el proceso Sidekiq. También es posible con el comando ***make sq***

## Instalación y ejecución en producción

La aplicación también puede ser desplegada en producción a través de contenedores Docker. Para ello se requiere instalar [Docker en linux](https://www.google.com/search?q=install+docker+linux).

COMPLETAR!

## Variables de entorno

COMPLETAR!

## Características:
  - Entorno de desarrollo y producción usando docker
  - Scaffolding usando makefile
  - Rails 4
  - PostgreSQL
  - Redis
  - Pundit
  - Pry
  - Sidekiq
  - I18N (es-CL, pt-BR, en)
  - Bower
  - Backup automático de BD (notificaciones via slack)
  - Integración con Slack

## TODO:
  - Agregar ActiveAdmin
  - Angular o React
  - Agregar linters
