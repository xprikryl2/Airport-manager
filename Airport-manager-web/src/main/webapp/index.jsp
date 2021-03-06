<%--
  Created by IntelliJ IDEA.
  User: robert
  Date: 9.12.2017
  Time: 0:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Airport Manager</title>

    <link rel="stylesheet" href="css/style.css"/>

    <%--BOOTSTRAP--%>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/momentjs/2.14.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular-resource.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.6/angular-route.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/angular_app.js"></script>
</head>
<body ng-app="airportManagerApp">
<nav class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#!/main">Airport Manager</a>
        </div>

        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="#!/flights" ng-if="currentUser">Flights</a></li>
                <li><a href="#!/stewards" ng-if="currentUser">Stewards</a></li>
                <li><a href="#!/airplanes" ng-if="currentUser">Airplanes</a></li>
                <li><a href="#!/destinations" ng-if="currentUser">Destinations</a></li>
            </ul>
            <a role="button" class="btn btn-default navbar-btn navbar-right" href="login.html" ng-if="!currentUser">Sign
                in</a>
            <a role="button" class="btn btn-default navbar-btn navbar-right" href="logout.html" ng-if="currentUser">Sign
                out</a>
        </div>
    </div>
</nav>

<div class="container" id="main" ng-cloak>

    <div>
        <!-- Bootstrap-styled alerts, visible when $rootScope.xxxAlert is defined -->
        <div ng-show="warningAlert" class="alert alert-warning alert-dismissible" role="alert">
            <button type="button" class="close" aria-label="Close" ng-click="hideWarningAlert()"><span
                    aria-hidden="true">&times;</span></button>
            <strong>Warning!</strong> <span>{{warningAlert}}</span>
        </div>
        <div ng-show="errorAlert" class="alert alert-danger alert-dismissible" role="alert">
            <button type="button" class="close" aria-label="Close" ng-click="hideErrorAlert()"><span aria-hidden="true">&times;</span>
            </button>
            <strong>Error!</strong> <span>{{errorAlert}}</span>
        </div>
        <div ng-show="successAlert" class="alert alert-success alert-dismissible" role="alert">
            <button type="button" class="close" aria-label="Close" ng-click="hideSuccessAlert()"><span
                    aria-hidden="true">&times;</span></button>
            <strong>Success!</strong> <span>{{successAlert}}</span>
        </div>

        <div ng-view></div>

    </div>
</div>

<footer class="footer">
    <div class="container">
        <p>&copy;&nbsp;Masaryk University</p>
    </div>
</footer>

</body>
</html>
