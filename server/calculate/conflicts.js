var db = require('../pg_db_adapter');
var GeoJSON = require('geojson');

function getFullElements(callback) {
    var params = [];
    db.fetchList('get_all_location', params, function (all) {
        callback(GeoJSON.parse(all, {Point: ['lat', 'lng']}));
    });
}

function getDevices(callback) {
    var params = [];
    db.fetchList('get_device_location', params, function (devices) {
        callback(GeoJSON.parse(devices, {Point: ['lat', 'lng']}));
    });
}

function getIncidents(callback) {
    var params = [];
    db.fetchList('get_incident_location', params, function (incidents) {
        callback(GeoJSON.parse(incidents, {Point: ['lat', 'lng']}));
    });
}

function checkIfInside(device, incident) {
    x = device.geometry.coordinates[0];
    y = device.geometry.coordinates[1];
    center_x = incident.geometry.coordinates[0];
    center_y = incident.geometry.coordinates[1];
    radius = incident.properties.radius;
    var first_operand = (x - center_x)^2 + (y - center_y)^2;
    var second_operand = radius^2;
    if(first_operand < second_operand)
        device.properties.conflict = 1;
    else
        device.properties.conflict = 0;
}

function getConflicts(callback) {
    getDevices(function (devices) {
        getIncidents(function (incidents) {
            for(var i = 0; i < incidents.features.length; i++) {
                for(var j = 0; j < devices.features.length; j++) {
                    checkIfInside(devices.features[j], incidents.features[i]);
                }
            }
            callback(devices);
        });
    });
}

module.exports = {
    returnFullElements: function (callback) {
        getFullElements(callback);
    },
    returnConflicts: function (callback) {
        getConflicts(callback);
    }
};