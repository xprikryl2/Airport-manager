'use strict';
var airportManagerApp = angular.module('airportManagerApp', ['ngRoute', 'managerControllers']);
var managerControllers = angular.module('managerControllers', []);

/* Configures URL fragment routing  */
airportManagerApp.config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider.
        when('/destination', {templateUrl: 'partials/destination.html', controller: 'DestinationCtrl'}).
        otherwise({redirectTo: '/pa165'});
    }]
);


/*
 * alert closing functions defined in root scope to be available in every template
 */
airportManagerApp.run(function ($rootScope) {
    $rootScope.hideSuccessAlert = function () {
        $rootScope.successAlert = undefined;
    };
    $rootScope.hideWarningAlert = function () {
        $rootScope.warningAlert = undefined;
    };
    $rootScope.hideErrorAlert = function () {
        $rootScope.errorAlert = undefined;
    };
});

/* Controllers */
/* Destination controller*/
function loadDestinations($http, $scope) {
    $http.get('/pa165/api/destination/').then(function (response) {
        $scope.destinations = response.data._embedded.destinations;
    });
}





managerControllers.controller('DestinationCtrl',
    function ($scope, $rootScope, $routeParams, $http) {
        $scope.sortType     = 'country';
        $scope.sortReverse  = false;
        $scope.searchQuery   = '';
        loadDestinations($http, $scope);

        $scope.newField = {};
        $scope.editing = false;


        $scope.editAppKey = function(field) {
            $scope.editing = $scope.appkeys.indexOf(field);
            $scope.newField = angular.copy(field);
        };

        $scope.saveField = function(index) {
            if ($scope.editing !== false) {
                $scope.appkeys[$scope.editing] = $scope.newField;
                $scope.editing = false;
            }
        };

        $scope.cancel = function(index) {
            if ($scope.editing !== false) {
                $scope.appkeys[$scope.editing] = $scope.newField;
                $scope.editing = false;
            }
        };

        $scope.deleteDestination = function (destination) {
            console.log("deleting destination with id=" + destination.id);
            $http.delete('/pa165/api/' + destination.id).then(function (response) {
                $scope.destinations = response.data._embedded.destinations;
            }.then(
                function success(response) {
                    console.log('deleted product ' + product.id + ' on server');
                    //display confirmation alert
                    $rootScope.successAlert = 'Deleted product "' + product.name + '"';
                    //load new list of all products
                    loadAdminProducts($http, $scope);
                },
                function error(response) {
                    console.log("error when deleting product");
                    console.log(response);
                    switch (response.data.code) {
                        case 'ResourceNotFoundException':
                            $rootScope.errorAlert = 'Cannot delete non-existent product ! ';
                            break;
                        default:
                            $rootScope.errorAlert = 'Cannot delete product ! Reason given by the server: '+response.data.message;
                            break;
                    }
                }
            ));
            loadDestinations($http, $scope);
        };


        $scope.newDestination = {
            'city': '',
            'country': ''
        };


        $scope.create = function (newDestination) {
            $http({
                method: 'POST',
                url: '/pa165/api/destination/create',
                data: newDestination
            }).then(function success(response) {
                console.log('created product');
                var createdDestination = response.data;
                //display confirmation alert
                $rootScope.successAlert = 'Destination "' + createdDestination.country + '" was created';
                //change view to list of products
                $location.path("/pa165/destination");
            }, function error(response) {
                //display error
                console.log("error when creating product");
                switch (response.data.code) {
                    case 'InvalidRequestException':
                        $rootScope.errorAlert = 'Sent data were found to be invalid by server ! ';
                        break;
                    default:
                        $rootScope.errorAlert = 'Cannot create destination ! Reason given by the server: '+response.data.message;
                        break;
                }
            });
        };

        $scope.update = function (destination) {
            $http({
                method: 'POST',
                url: '/pa165/api/destination/update',
                data: destination
            }).then(function success(response) {
                console.log('created product');
                var createdDestination = response.data;
                //display confirmation alert
                $rootScope.successAlert = 'Destination "' + createdDestination.country + '" was updated';
                //change view to list of products
                $location.path("/pa165/destination");
            }, function error(response) {
                //display error
                console.log("error when creating product");
                switch (response.data.code) {
                    case 'InvalidRequestException':
                        $rootScope.errorAlert = 'Sent data were found to be invalid by server ! ';
                        break;
                    default:
                        $rootScope.errorAlert = 'Cannot update destination ! Reason given by the server: '+response.data.message;
                        break;
                }
            });
        };


});






