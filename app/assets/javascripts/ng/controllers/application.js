(function () {
  "use strict";

  // Define controller
  function applicationCtrl ($scope) {
    console.log('applicationCtrl: Hi')
    var data = $scope.data = {}
    var view = $scope.view = {}
    var fn = $scope.fn = {}
  }

  // Register controller
  angular
    .module('app.controllers.application', [])
    .controller('applicationCtrl', [
      '$scope',
      applicationCtrl
    ])
})()
