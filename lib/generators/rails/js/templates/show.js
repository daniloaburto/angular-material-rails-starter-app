/*
 * Controller for <%= class_name %>
 * Action: Show
 * If you want to use this controller remember:
 *     - Require this file in assets/javascripts/application.js
 *     - Add this controller to angular in assets/javascripts/ng/app.js
 *         - Add line -> 'app.controllers.<%= plural_table_name %>.show'
 *     - Uncomment "<%= plural_table_name %>ShowCtrl" from views/<%= plural_table_name %>/show.html.erb
 */
;(function () {
  "use strict";

  // Define controller
  function <%= plural_table_name %>ShowCtrl ($scope) {
    console.log('<%= plural_table_name %>ShowCtrl: Hi')
    var data = $scope.data = {}
    var view = $scope.view = {}
    var fn = $scope.fn = {}
  }

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.show', [])
    .controller('<%= plural_table_name %>ShowCtrl', [
      '$scope',
      <%= plural_table_name %>ShowCtrl
    ])
})();
