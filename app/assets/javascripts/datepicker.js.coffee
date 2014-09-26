jQuery ->
  $('.date').datepicker({
  		format: 'mm yyyy',
  		minViewMode: 1,
  		autoclose: true,
  		language: "ru"
  });

jQuery ->
  $('.datepicker, .vacation, .sick-list').datepicker({
      format: 'yyyy-mm-dd',
      todayBtn: "linked",
      todayHighlight: true,
      autoclose: true,
      language: "ru"
  });