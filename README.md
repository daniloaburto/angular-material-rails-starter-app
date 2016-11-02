# Rails Seed

## Instalación y ejecución para desarrollo en OS X

El entorno de desarrollo está aislado y autocontenido por medio de contenedores, por lo cual es necesario instalar [Docker](https://www.google.com/search?q=install+docker+os+x).

Para construir la imagen docker del proyecto ejecutar:

  ```
  $ make build
  ```

Luego, para levantar los contenedores se debe ejecutar el siguiente comando:

  ```
  $ make run
  ```

Para entrar al contenedor de la aplicación Rails, ejecutar en otra pestaña:

  ```
  $ make enter
  ```

Finalmente, ya dentro del contenedor para levantar la aplicación rails:

  ```
  $ make server
  ```

Para configurar el proyecto por primera vez, entrar a un contenedor rails y ejecutar:

  ```
  $ make init
  ```

Para probar el scaffolding, ingresar a un contenedor rails y ejecutar:

  ```
  $ make redo
  ```

Una vez finalizado el scaffolding se puede visitar algunos de los recursos creados, por ejemplo: [http://localhost:3000/countries](http://localhost:3000/countries)

## Instalación y ejecución en producción

La aplicación también puede ser desplegada en producción a través de contenedores Docker. Para ello se requiere instalar [Docker en linux](https://www.google.com/search?q=install+docker+linux).

Para levantar los servicios:

  ```
  $ POSTGRES_USER=<user> POSTGRES_PASSWORD=<pass> docker-compose up -d
  ```

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

## TODO:
  - Backup automático de BD
  - Agregar ActiveAdmin
  - Integración con Slack
  - Angular o React
  - Agregar linters
