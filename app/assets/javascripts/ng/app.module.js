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
    'app.directives.app.notification',

    // Global Components

    'app.controllers.base',
    'app.controllers.home',
    // 'app.controllers.resource.action'

    // BEGIN: DO NOT DELETE FOLLOWING TAG
    // <controllers_scaffold>

    // </controllers_scaffold>
    // END: DO NOT DELETE FOLLOWING TAG
  ])
})();
