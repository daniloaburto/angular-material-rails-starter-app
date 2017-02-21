;(function () {
  "use strict";

  // Define Controller
  function ComponentController () {
    var vm = this
  }

  // Define component
  var ComponentObject = {
    transclude: true,
    bindings: {
      type: '@',
      title: '@',
    },
    template: [
      '<div ng-show="!isHidden" class="app-notification app-notification-{{$ctrl.type}}">',
        '<span class="app-notification-close-btn" ng-click="isHidden = !isHidden">&times;</span>',
        '<span class="app-notification-title">{{$ctrl.title}}</span>',
        '<span class="app-notification-content">',
          '<ng-transclude></ng-transclude>',
        '</span>',
      '</div>',
    ].join(''),
    controller: ComponentController
  }

  // Inject dependencies
  // ComponentController.$inject = []

  // Register Component
  angular
    .module('app.components.app-notification', [])
    .component('appNotification', ComponentObject)
})();
