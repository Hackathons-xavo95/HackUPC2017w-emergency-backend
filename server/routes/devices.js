var db = require('../pg_db_adapter');
var express = require('express');

module.exports = function (parentRouter) {
    var devicesRouter = express.Router();

    devicesRouter
        .get('/get_status', function (request, response) {
            var params = [];

            db.fetchListAndReturn('get_device_location', params, response);
        })

        .post('/set_status', function (request, response) {
            var body = request.body;
            var params = [
                body['id'],
                body['lat'],
                body['lng']
            ];

            db.fetchItemAndReturn('set_device_location', params, response);
        });

    parentRouter.use('/devices', devicesRouter);
};
