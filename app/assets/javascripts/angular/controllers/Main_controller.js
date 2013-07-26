/**
 *
 * Created with JetBrains RubyMine.
 * User: morodeer
 * Date: 23.07.13
 * Time: 19:34
 * To change this template use File | Settings | File Templates.
 */






window.App.controller('MainCtrl', function($scope,$resource,$http) {
    $scope.authors = ['Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Dakota', 'North Carolina', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'];

    $scope.get_authors = function(query) {
        return $http.get('/authors/search.json?query='+query).then(function(response) {
            return response.data;
        })
    }

    $scope.get_books = function(query) {
        query = (query) ? query : ''
        return $http.get('/books/search.json?author_id='+$scope.selected_author.id+'&query='+query+'').then(function(response) {
            $scope.books = response.data;
            return response.data;
        })
    }

});

window.App.controller('UsersIndexCtrl', function($scope,$resource,$http) {
    $scope.users = users;
    $scope.friends = friends;

    $scope.update_users_list = function() {
        if ($scope.friends) {
            $scope.current_user = current_user;

            if ($scope.search_query.length < 4) {
                query = '';
            }
            else
            {
                query = $scope.search_query;
            }
            return $http.get('/friends/search.json?user_id='+current_user+'&query='+$scope.search_query+'')
                .then(function(response){
                    $scope.users = response.data;
                    return response.data;
                })
        }        else {

            return $http.get('/users/search.json?query='+$scope.search_query+'')
                .then(function(response){
                    $scope.users = response.data;
                    return response.data;
                })
        }
    }
})
