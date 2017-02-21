/* ONE CONTROLLER TO RULE THEM ALL */

;(function () {
  "use strict";

  // Define controller
  function BaseController ($scope, $log, $mdMedia, $mdSidenav, $window, $mdToast, APP_CONSTANTS) {
    $log.debug('BaseController: Hi!')

    var vm = this

    vm.app = {
      name: APP_CONSTANTS.name,
      icon_svg_url:  APP_CONSTANTS.icon_svg_url,
      material_theme: APP_CONSTANTS.material_theme,
      material_theme_options: APP_CONSTANTS.material_theme_options
    }

    vm.breakpoint = $mdMedia('gt-sm')
    $scope.$watch(function() { return $mdMedia('gt-sm'); }, function(breakpoint) {
      vm.breakpoint = breakpoint
    })

    vm.openMenu = function ($mdMenu, $event) {
      $log.debug('baseController: openMenu')
      $mdMenu.open($event)
    }

    vm.toggleSidemenu = function (menuID) {
      $log.debug('baseController: toggleLeftSidemenu')
      $mdSidenav(menuID).toggle()
    }

    vm.historyBack = function() {$window.history.back()}

    vm.showToast = function () {
      $mdToast.show(
        $mdToast.simple()
          .textContent('Simple Toast!')
          .position('top right')
          .hideDelay(3000)
          .theme("success-toast")
      )
    }

    window.vm = vm
  }

  // Inject dependencies
  BaseController.$inject = [
    '$scope',
    '$log',
    '$mdMedia',
    '$mdSidenav',
    '$window',
    '$mdToast',
    'APP_CONSTANTS'
  ]
  // Register controller
  angular
    .module('app.controllers.base', [])
    .controller('BaseController', BaseController)
})();
