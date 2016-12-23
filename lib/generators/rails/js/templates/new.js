/*
 * Controller for <%= class_name %>
 * Action: New
 * If you want to use this controller remember:
 *     - Require this file in assets/javascripts/application.js
 *         - Add line -> //= require ng/controllers/<%= plural_table_name %>/new
 *     - Add this controller to angular in assets/javascripts/ng/app.js
 *         - Add line -> 'app.controllers.<%= plural_table_name %>.new'
 *     - Uncomment "<%= plural_table_name %>NewCtrl" from views/<%= plural_table_name %>/new.html.erb
 */
;(function () {
  "use strict";

  // Define controller
  function <%= plural_table_name %>NewCtrl ($scope) {
    console.log('<%= plural_table_name %>NewCtrl: Hi')
    var data = $scope.data = angular.extend({}, rails_data)
    var view = $scope.view = {}
    var fn = $scope.fn = {}
  }

  // Inject dependencies
  <%= plural_table_name %>NewCtrl.$inject = ['$scope']

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.new', [])
    .controller('<%= plural_table_name %>NewCtrl', <%= plural_table_name %>NewCtrl)
})();
