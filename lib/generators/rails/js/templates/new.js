/*
 * Controller for <%= class_name %>
 * Action: New
 */
;(function () {
  'use strict';

  // Define controller
  function <%= plural_table_name.camelize %>NewCtrl ($log) {
    $log.debug('<%= plural_table_name.camelize %>NewCtrl: Hi')
    this.data = angular.extend({}, rails_data || {})
  }

  // Inject dependencies
  <%= plural_table_name.camelize %>NewCtrl.$inject = ['$log']

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.new', [])
    .controller('<%= plural_table_name.camelize %>NewCtrl', <%= plural_table_name.camelize %>NewCtrl)
})();
