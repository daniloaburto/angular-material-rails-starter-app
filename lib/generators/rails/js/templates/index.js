/*
 * Controller for <%= class_name %>
 * Action: Index
 */
;(function () {
  "use strict";

  // Define controller
  function <%= plural_table_name.camelize %>IndexCtrl ($log) {
    $log.debug('<%= plural_table_name.camelize %>IndexCtrl: Hi')
    var vm = this
    vm.data = angular.extend({}, rails_data || {})

    vm.search = {
      show: false,
      query: ''
    }
  }

  // Inject dependencies
  <%= plural_table_name.camelize %>IndexCtrl.$inject = ['$log']

  // Register controller
  angular
    .module('app.controllers.<%= plural_table_name %>.index', [])
    .controller('<%= plural_table_name.camelize %>IndexCtrl', <%= plural_table_name.camelize %>IndexCtrl)
})();
