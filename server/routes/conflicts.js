var db = require('../pg_db_adapter');
var express = require('express');
var conflicts = require('../calculate/conflicts');

module.exports = function (parentRouter) {
    var devicesRouter = express.Router();

    devicesRouter
        .get('/get_full_elements', function (request, response) {
            conflicts.returnFullElements(function (jsondata) {
                return response.json(jsondata);
            });
        })

        .get('/get_conflicts', function (request, response) {
            conflicts.returnConflicts(function (jsondata) {
                return response.json(jsondata);
            });
        });

    parentRouter.use('/conflicts', devicesRouter);
};
