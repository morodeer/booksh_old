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
