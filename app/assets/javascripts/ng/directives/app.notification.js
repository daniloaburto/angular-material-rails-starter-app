;(function () {
  "use strict";

  function AppNotificationDirective () {

    // Define Directive Controller
    function DirectiveController () {
      var vm = this
    }

    // Inject dependencies to controller
    // DirectiveController.$inject = []

    // Define directive link fn
    function linker(scope, element, attr) {

      // Bind close btn
      var closeClass = '.app-notification-close-btn'
      var closeBtns = angular.element(element[0].querySelector(closeClass))
      angular.forEach(closeBtns, function (btn) {
        angular.element(btn).bind("click", function () {
          element.remove()
        })
      })
    }

    // Define object
    var DirectiveObject = {
      restrict: 'E',
      transclude: true,
      scope: {
        type: '@',
        title: '@',
      },
      template: [
        '<div class="app-notification app-notification-{{type}}">',
          '<span class="app-notification-close-btn">&times;</span>',
          '<span class="app-notification-title">{{title}}</span>',
          '<span class="app-notification-content">',
            '<ng-transclude></ng-transclude>',
          '</span>',
        '</div>',
      ].join(''),
      link: linker,
      controller: DirectiveController
    }

    return DirectiveObject
  }

  // Inject dependencies to directive
  // AppNotificationDirective.$inject = []

  // Register Directive
  angular
    .module('app.directives.app.notification', [])
    .directive('appNotification', AppNotificationDirective)
})();
