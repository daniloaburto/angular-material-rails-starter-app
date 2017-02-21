;(function() {

  // Define directive
  function BtnDeleteDirective ($mdDialog) {
    return {
      restrict: "A",
      link: function($scope, element, attrs, controller) {
        if (element[0].tagName.toUpperCase() !== "A") {return;}

        return element.bind("click", function (e) {

          var confirm = $mdDialog.confirm()
                .title(attrs.title)
                .textContent(attrs.confirm)
                .ariaLabel(attrs.title)
                .targetEvent(e)
                .ok(I18n.t('ok', {scope: 'js.confirmation'}))
                .cancel(I18n.t('abort', {scope: 'js.confirmation'}))

          $mdDialog.show(confirm).then(function () {
            var csrfParam, csrfToken, form, imethod, _ref, _ref1;

            form = document.createElement("form")
            form.setAttribute("action", attrs.href)
            form.setAttribute("method", "POST")

            imethod = document.createElement("input")
            imethod.setAttribute("type", "hidden")
            imethod.setAttribute("name", "_method")
            imethod.setAttribute("value", attrs.method)
            form.appendChild(imethod)

            csrfParam = (_ref = document.querySelector('meta[name=csrf-param]')) != null ? _ref.content : void 0
            csrfToken = (_ref1 = document.querySelector('meta[name=csrf-token]')) != null ? _ref1.content : void 0

            if (csrfParam && csrfToken) {
              imethod = document.createElement("input")
              imethod.setAttribute("type", "hidden")
              imethod.setAttribute("name", csrfParam)
              imethod.setAttribute("value", csrfToken)
              form.appendChild(imethod)
            }

            document.body.appendChild(form)
            form.submit()
          }, function() {

          })

          e.preventDefault()
          return e.stopPropagation()
        })
      }
    }
  }

  // Inject dependencies
  BtnDeleteDirective.$inject = ['$mdDialog']

  // Register directive
  angular
    .module('app.directives.btn.delete', [])
    .directive('method', BtnDeleteDirective)
})();
