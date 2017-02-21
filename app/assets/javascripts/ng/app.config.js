;(function () {
  'use strict'

  angular.module('app')
  .constant('APP_CONSTANTS',{
    name: 'Project Name',
    material_theme: {
      name: 'default',
      primary: 'blue',
    },
    material_theme_options: [
      'red', 'pink', 'purple', 'deep-purple', 'indigo', 'blue', 'light-blue',
      'cyan', 'teal', 'green', 'light-green', 'lime', 'yellow', 'amber',
      'orange', 'deep-orange', 'brown', 'grey', 'blue-grey'
    ],
    debug: true
  })
  .config(function ($logProvider, $mdThemingProvider, APP_CONSTANTS) {
    $logProvider.debugEnabled(APP_CONSTANTS.debug)

    $mdThemingProvider.theme(APP_CONSTANTS.material_theme.name)
     .primaryPalette(APP_CONSTANTS.material_theme.primary)
  })

  .config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.withCredentials = true
  }])

  .config(['$sceDelegateProvider', function($sceDelegateProvider) {
    $sceDelegateProvider.resourceUrlWhitelist(['**']);
  }])

  // Se inicia angular.js manualmente
  angular.element().ready(function() {
    angular.resumeBootstrap([window.app['name']])
  })

})();
