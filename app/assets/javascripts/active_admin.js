//= require active_admin/base
//= require just_datetime_picker/nested_form_workaround
//= require select2

$(document).ready(function() {
  $('.need-user-autocomplete').select2({
    dropdownAutoWidth : true,
    width: 'auto',
    ajax: {
      url: '/api/user/autocomplete',
      cache: false
    }
  });
})