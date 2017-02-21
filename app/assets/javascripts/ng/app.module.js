;(function () {
  'use strict'

  window.app = angular.module('app', [
    // angular core
    'ngResource',

    // angular addons
    'ngAnimate',
    'ngMessages',
    'ngAria',
    'ngMaterial',
    'ngMdIcons',
    'md.data.table',

    // Interceptors

    // Global Services

    // Global Filters

    // Global Directives
    'app.directives.btn.delete',

    // Global Components
    'app.components.app-notification',

    'app.controllers.base',
    'app.controllers.home',
    // 'app.controllers.resource.action'

    // <controllers_scaffold>

    // </controllers_scaffold>

    // Components
  ])
})();
