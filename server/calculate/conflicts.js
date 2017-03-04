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

/** Converts numeric degrees to radians */
if (typeof(Number.prototype.toRad) === "undefined") {
    Number.prototype.toRad = function() {
        return this * Math.PI / 180;
    }
}

function degreeToMeters(lat1, lat2, lon1, lon2) {
    var R = 6371000;
    var dLat = (lat2-lat1).toRad();
    var dLon = (lon2-lon1).toRad();
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) *
        Math.sin(dLon/2) * Math.sin(dLon/2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    var d = R * c;
    return d;
}

function checkIfInside(device, incident) {
    x = device.geometry.coordinates[0];
    y = device.geometry.coordinates[1];
    center_x = incident.geometry.coordinates[0];
    center_y = incident.geometry.coordinates[1];
    radius = incident.properties.radius;
    var first_operand = (x - center_x)^2 + (y - center_y)^2;
    first_operand = degreeToMeters(x, center_x, y, center_y);
    var second_operand = radius^2;
    if(first_operand < second_operand)
        device.properties.conflict = 1;
    else
        device.properties.conflict = 0;
}

function getConflicts(callback) {
    getDevices(function (devices) {
        getIncidents(function (incidents) {
            var j = 0;
            for(var i = 0; i < incidents.features.length; i++) {
                for(j = 0; j < devices.features.length; j++) {
                    checkIfInside(devices.features[j], incidents.features[i]);
                }
            }
            var finaljson = devices;
            for(var i = 0; i < incidents.features.length; i++) {
                finaljson.features[j] = incidents.features[i];
                j++;
            }
            callback(finaljson);
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