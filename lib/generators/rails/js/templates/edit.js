/*
 * Controller for <%= class_name %>
 * Action: Edit
 */
;(function () {
  'use strict';

  // Define controller
  function <%= plural_table_name.camelize %>EditCtrl ($log) {
    $log.debug('<%= plural_table_name.camelize %>EditCtrl: Hi')
    this.data = angular.extend({}, rails_data || {})
  }

  // Inject dependencies
  <%= plural_table_name.camelize %>EditCtrl.$inject = ['$log']

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.edit', [])
    .controller('<%= plural_table_name.camelize %>EditCtrl', <%= plural_table_name.camelize %>EditCtrl)
})();
