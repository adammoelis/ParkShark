// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require chosen-jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.easing.1.3.min
//= require jquery.form
//= require jquery.validate.min
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require bootstrap-hover-dropdown.min
//= require skrollr.min
//= require skrollr.stylesheets.min
//= require waypoints.min
//= require waypoints-sticky.min
//= require owl.carousel.min
//= require jquery.isotope.min
//= require jquery.easytabs.min
//= require google.maps.api.v3
//= require viewport-units-buggyfill
//= require scripts
//= require maskedinput
//= require turbolinks
//= require messages
//= require ImageSelect.jquery.js
//= require gmaps-auto-complete
//= require_tree .

$(function() {
    $('.datetimepicker1').datetimepicker();
    getLocation()
});

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(sendPositionData);
    } else {
        return "Geolocation is not supported by this browser.";
    }
}

function sendPositionData(position) {
    $.post( "/my_location", { latitude: position.coords.latitude, longitude: position.coords.longitude } );
}

jQuery(function() {
  var completer;

  completer = new GmapsCompleter({
    inputField: '#q',
    errorField: '#gmaps-error'
  });

  completer.autoCompleteInit({
    country: "us",
    region: "us"
  });
});
