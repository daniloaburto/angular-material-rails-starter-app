/*
 * Controller for <%= class_name %>
 * Action: Index
 * If you want to use this controller remember:
 *     - Require this file in assets/javascripts/application.js
 *     - Add this controller to angular in assets/javascripts/ng/app.js
 *         - Add line -> 'app.controllers.<%= plural_table_name %>.index'
 *     - Uncomment "<%= plural_table_name %>IndexCtrl" from views/<%= plural_table_name %>/index.html.erb
 */
;(function () {
  "use strict";

  // Define controller
  function <%= plural_table_name %>IndexCtrl ($scope) {
    console.log('<%= plural_table_name %>IndexCtrl: Hi')
    var data = $scope.data = {}
    var view = $scope.view = {}
    var fn = $scope.fn = {}
  }

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.index', [])
    .controller('<%= plural_table_name %>IndexCtrl', [
      '$scope',
      <%= plural_table_name %>IndexCtrl
    ])
})();
