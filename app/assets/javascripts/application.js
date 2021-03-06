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
//= require jquery.autosize
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
//= require viewport-units-buggyfill
//= require scripts
//= require maskedinput
//= require turbolinks
//= require messages
//= require ImageSelect.jquery.js
//= require gmaps-auto-complete
//= require bootstrap-datepicker
//= require underscore
//= require gmaps/google
//= require bootstrap-slider
//= require_tree .

$(function() {
    getLocation();
    $('#max-price').bootstrapSlider({
    	formatter: function(value) {
    		return 'Current value: ' + value;
    	}
    });
    $('#advanced-search').hide();
    $('#modify-search').click(function() {
      $('#advanced-search').toggle();
      if ($('#advanced-search').is(":visible")){
        $('#modify-search').text('Hide Search');
      }
      else {
        $('#modify-search').text('Modify Search');
      }
    })

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

  completer2 = new GmapsCompleter({
    inputField: '#destination',
    errorField: '#gmaps-error'
  });

  completer2.autoCompleteInit({
    country: "us",
    region: "us"
  });
});

function modifySearch() {
  $('#hide-advanced-search').click(function(){
    $('#advanced-search').hide()
    $('#hide-advanced-search').replaceWith('<button id="add-advanced-search" class="btn btn-default">Click to filter</button>')
    addAdvancedSearch()
  })
}

function addAdvancedSearch(){
  $('#add-advanced-search').click(function(){
    $('#advanced-search').show()
    $('#add-advanced-search').replaceWith('<button id="hide-advanced-search" class="btn btn-default">Hide Search</button>')
    hideAdvancedSearch()
  })
}

function addLocationSearch(){
  $('#add-location-search').click(function(){
    $('#location-search-nearby').toggle()
    if($('#location-search-nearby').is(":visible")){
      $("#add-location-search").text("Hide")
    }
    else {
      $("#add-location-search").text("Change Location")
    }
  })
}
