var app = angular.module('application', [
  'ngResource',

  // Services

  // Interceptors

  // Filters

  // Controllers
  'app.controllers.application',
  'app.controllers.home',
  // 'app.controllers.resource.action'
])
.run(function() {

})

.config(['$httpProvider', function($httpProvider) {
  // $httpProvider.interceptors.push('SessionInterceptor')

  // Se envian las credenciales por defecto
  $httpProvider.defaults.withCredentials = true
}])

.config(['$httpProvider', function($httpProvider) {
    // $httpProvider.defaults.timeout = 5000;
}])

// Se inicia angular.js manualmente
angular.element().ready(function() {
  angular.resumeBootstrap([app['name']])
})
