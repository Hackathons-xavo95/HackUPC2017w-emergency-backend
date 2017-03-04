var db = require('../pg_db_adapter');
var express = require('express');

module.exports = function (parentRouter) {
    var usersRouter = express.Router();

    usersRouter
        .post('/register', function (request, response) {
            var body = request.body;
            var params = [
                body['email'],
                body['username'],
                body['password']
            ];

            db.fetchItemAndReturn('users_register', params, response);
        })
        .post('/login', function (request, response) {
            var body = request.body;
            var params = [
                body['username'],
                body['password']
            ];

            db.fetchItemAndReturn('users_login', params, response);
        });

    parentRouter.use('/users', usersRouter);
};
