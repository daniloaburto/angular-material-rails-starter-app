/*
 * Controller for <%= class_name %>
 * Action: Show
 */
;(function () {
  'use strict';

  // Define controller
  function <%= plural_table_name.camelize %>ShowCtrl ($log) {
    $log.debug('<%= plural_table_name.camelize %>ShowCtrl: Hi')
    this.data = angular.extend({}, rails_data || {})
  }

  // Inject dependencies
  <%= plural_table_name.camelize %>ShowCtrl.$inject = ['$log']

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.show', [])
    .controller('<%= plural_table_name.camelize %>ShowCtrl', <%= plural_table_name.camelize %>ShowCtrl)
})();
