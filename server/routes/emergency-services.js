var db = require('../pg_db_adapter');
var express = require('express');

module.exports = function (parentRouter) {
    var emergencyServicesRouter = express.Router();

    emergencyServicesRouter
        .post('/register', function (request, response) {
            var body = request.body;
            var params = [
                body['email'],
                body['username'],
                body['password']
            ];

            db.fetchItemAndReturn('emergency_services_register', params, response);
        })
        .post('/login', function (request, response) {
            var body = request.body;
            var params = [
                body['username'],
                body['password']
            ];

            db.fetchItemAndReturn('emergency_services_login', params, response);
        });

    parentRouter.use('/emergency-services', emergencyServicesRouter);
};
