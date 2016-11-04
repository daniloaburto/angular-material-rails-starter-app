# Rails Seed

## Instalación y ejecución para desarrollo en OS X

El entorno de desarrollo está aislado y autocontenido por medio de contenedores, por lo cual es necesario instalar [Docker](https://www.google.com/search?q=install+docker+os+x).

Para construir la imagen docker del proyecto ejecutar:

  ```
  $ make build
  ```

Luego, para levantar los contenedores se debe ejecutar el siguiente comando:

  ```
  $ make run # también es posible usar 'make start' para ejecutar en background
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
