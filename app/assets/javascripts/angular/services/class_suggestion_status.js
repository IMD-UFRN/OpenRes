OpenResVeiculosApp.factory('ClassSuggestionStatus', function($http, $timeout) {

  return {
    update: function() {
      var status = {};

      (function poll () {
        $timeout(function () {
          $http.get('/class_suggestions/status').then(function(response){
            angular.extend(status, response.data);
          })
          poll();
        }, 3000);
      })();

      return status; 
    }
  };
});

OpenResVeiculosApp.controller('ClassSuggestionController', function($scope, ClassSuggestionStatus) {
  $scope.status = ClassSuggestionStatus.update();
  $scope.Math = window.Math;
});