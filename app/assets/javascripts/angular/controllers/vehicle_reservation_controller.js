var urlGetParams = function(sParams){

    var sHash = sParams|| window.location.search,
        result = {};

    sHash.substring(sHash.indexOf('?') + 1).split('&').forEach(function(el) {
        var kv = el.split('=');
        result[kv[0]] = decodeURIComponent(kv[1]);
    });

    return result;

};


OpenResVeiculosApp.controller('CarReservationsCtrl', function ($scope, $http, $location) {
  $scope.preview = {};

  $scope.date_selected = moment().format("D/M/YYYY");

  $scope.updatePreview = function(){

    if($scope.vehicle == undefined || $scope.vehicle == 0){
      var params = urlGetParams(false);
      $scope.vehicle = params.vehicle_id;
      return;
    }

    $http.get('/vehicles/'+$scope.vehicle+'/reservations.json?date=' + $scope.date_selected)
      .success(function(data) {
        $scope.preview = data;
      })
      .error(function(data) {
        console.log('Error: ' + data);
      });
  };
  $scope.updatePreview();
})
