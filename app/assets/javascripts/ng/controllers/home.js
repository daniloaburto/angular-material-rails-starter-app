;(function () {
  "use strict";

  // Define controller
  function homeCtrl ($scope) {
    console.log('homeCtrl: Hi')
    var data = $scope.data = {}
    var view = $scope.view = {}
    var fn = $scope.fn = {}
  }

  // Register controller
  angular
    .module('app.controllers.home', [])
    .controller('homeCtrl', [
      '$scope',
      homeCtrl
    ])
})();
