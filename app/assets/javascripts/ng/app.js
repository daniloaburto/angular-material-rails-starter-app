// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.controllers' is found in controllers.js
var app = angular.module('starter', [
  'ionic',
  'ngCordova',
  'ngResource',
  'angular-cache',

  'uiGmapgoogle-maps',
  'LocalForageModule',
  'timer',

  'app.loggers.file',
  'app.loggers.cloud',
  'app.loggers.logger',

  'app.services.alert',
  'app.services.auth',
  'app.services.session',
  'app.services.physics',
  'app.services.gps',
  'app.services.geo',
  'app.services.event',
  'app.services.tracking',
  'app.services.vehicle',
  'app.services.route',
  'app.services.gmaps',
  'app.services.marker',
  'app.services.sync',

  'app.interceptors.session',

  'app.filters.time',
  'app.filters.date',

  'app.controllers.application',
  'app.controllers.sessions',
  'app.controllers.vehicles',
  'app.controllers.routes',
  'app.controllers.features'
])
.constant('env', ENV)
.constant('config', CONFIG[ENV])
.config(function($ionicConfigProvider) {
  if (!ionic.Platform.isIOS()) {

    $ionicConfigProvider.scrolling.jsScrolling(false)
  }
})
.run(function($ionicPlatform, $cordovaSQLite, TrackingService, $state, $ionicPopup) {

  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins.Keyboard) {
      window.cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      window.cordova.plugins.Keyboard.disableScroll(true);
    }
    if (window.cordova && window.cordova.plugins.backgroundMode) {
      window.cordova.plugins.backgroundMode.setDefaults({
        title:  'Drivin',
        ticker: 'Drivin está ejecutándose...',
        text:   'Aplicación ejecutándose'
      })
    }

    //
    $ionicPlatform.registerBackButtonAction(function (event) {
      if ($state.current.name == "app.routes") {

        var confirmPopup = $ionicPopup.confirm({
        title: 'Estás a punto de cerrar la aplicación',
        template: '¿Estás seguro de que deseas salir?'
        })
        confirmPopup.then(function(ok) {
          if (ok) {
            TrackingService.hardStop()
            navigator.app.exitApp()
          }
        })
      }
      else {
        navigator.app.backHistory()
      }
    }, 100)

    // Initialize data directory
    var cordova = window.cordova || {file:{}}
    var config = CONFIG[ENV]
    if (ionic.Platform.isIOS()) {
      if (cordova.file.hasOwnProperty('dataDirectory'))
        cordova.file.appDirectory = cordova.file.dataDirectory
    }
    else if (ionic.Platform.isAndroid()) {
      if (cordova.file.hasOwnProperty('externalDataDirectory'))
        cordova.file.appDirectory = cordova.file.externalDataDirectory
    }

    // Is there an incompleted tracking?
    TrackingService.stop()
  })
})

.config( [
  '$compileProvider',
  function($compileProvider) {
    $compileProvider.aHrefSanitizationWhitelist(/^\s*(https?|ftp|mailto|waze|chrome-extension):/);
  }
])

.config(function(uiGmapGoogleMapApiProvider) {
  uiGmapGoogleMapApiProvider.configure({
    //    key: 'your api key',
    v: '3.20', //defaults to latest 3.X anyhow
    libraries: 'weather,geometry,visualization'
  })
})

.config(['$httpProvider', function($httpProvider) {
  $httpProvider.interceptors.push('SessionInterceptor')
}])

.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.timeout = 5000;
}])

.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider

  // Session
  .state('session', {
    url: '/session',
    abstract: true,
    templateUrl: 'templates/layouts/session.html',
    controller: 'sessions'
  })

  .state('session.startup', {
    url: '/startup',
    views: {
      'mainView': {
        template: '<ion-view cache-view="false">' +
                    '<ion-content class="background background-primary">' +
                      '&nbsp;' +
                    '</ion-content>'+
                  '</ion-view>',
        controller: function ($scope, $state, $ionicHistory, SessionService) {
          console.log('startup')

          $ionicHistory.clearHistory()
          $ionicHistory.nextViewOptions({
            disableBack: true
          })

          SessionService.getCurrentUser().then(function (user) {
            if (user != null) {
              $state.go('app.routes', {
                vehicle_id: user.vehicle.id,
                vehicle_plate: user.vehicle.plate
              })
            }
            else {
              $state.go('session.new')
            }
          })
        }
      }
    }
  })

  .state('session.new', {
    url: '/new',
    views: {
      'mainView': {
        templateUrl: 'templates/sessions/new.html',
        controller: 'sessions#new'
      }
    }
  })


  // Drivin
  .state('app', {
    url: '/app',
    abstract: true,
    templateUrl: 'templates/layouts/layout.html',
    controller: 'application'
  })

  .state('app.vehicles', {
    url: '/vehicles',
    views: {
      'headerView': {
        templateUrl: 'templates/layouts/_header.html',
      },
      'mainView': {
        templateUrl: 'templates/vehicles/index.html',
        controller: 'vehicles#index'
      }
    }
  })

  .state('app.routes', {
    url: '/vehicles/:vehicle_id/routes?vehicle_plate',
    views: {
      'mainView': {
        templateUrl: 'templates/routes/index.html',
        controller: 'routes#index'
      }
    }
  })

  .state('app.show_route', {
    url: '/vehicles/:vehicle_id/routes/:route_id?vehicle_plate&route_status',
    views: {
      'mainView': {
        templateUrl: 'templates/routes/show.html',
        controller: 'routes#show'
      }
    }
  })

  // Dev Features
  .state('app.features', {
    url: '/features',
    views: {
      'mainView': {
        templateUrl: 'templates/features/index.html',
        controller: 'features#index'
      }
    }
  })

  .state('app.features-geo', {
    url: '/features/geo',
    views: {
      'mainView': {
        templateUrl: 'templates/features/geo.html',
        controller: 'features#geo'
      }
    }
  })

  .state('app.features-sqlite', {
    url: '/features/sqlite',
    views: {
      'mainView': {
        templateUrl: 'templates/features/sqlite.html',
        controller: 'features#sqlite'
      }
    }
  })

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/session/startup');
});


if (window.cordova !== undefined) {
  document.addEventListener('deviceready', function() {

    // Se inicia angular.js manualmente
    angular.element().ready(function() {
      angular.resumeBootstrap([app['name']])
    })
  })
}
else {
    console.log('cordova not found, booting Angular manually');

  // Se inicia angular.js manualmente
  angular.element().ready(function() {
    angular.resumeBootstrap([app['name']])
  })
}
