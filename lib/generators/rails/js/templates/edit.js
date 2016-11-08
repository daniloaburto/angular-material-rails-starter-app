/*
 * Controller for <%= class_name %>
 * Action: Edit
 * If you want to use this controller remember:
 *     - Require this file in assets/javascripts/application.js
 *     - Add this controller to angular in assets/javascripts/ng/app.js
 *         - Add line -> 'app.controllers.<%= plural_table_name %>.edit'
 *     - Uncomment "<%= plural_table_name %>EditCtrl" from views/<%= plural_table_name %>/edit.html.erb
 */
;(function () {
  "use strict";

  // Define controller
  function <%= plural_table_name %>EditCtrl ($scope) {
    console.log('<%= plural_table_name %>EditCtrl: Hi')
    var data = $scope.data = {}
    var view = $scope.view = {}
    var fn = $scope.fn = {}
  }

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.edit', [])
    .controller('<%= plural_table_name %>EditCtrl', [
      '$scope',
      <%= plural_table_name %>EditCtrl
    ])
})();
