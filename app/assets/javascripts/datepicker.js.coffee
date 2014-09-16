jQuery ->
  $('.date').datepicker({
  		format: 'MM yyyy',
  		minViewMode: 1,
  		autoclose: true,
  		language: "en"
  });

jQuery ->
  $('.datepicker, .vacation, .sick-list').datepicker({
      format: 'yyyy-mm-dd',
      todayBtn: "linked",
      todayHighlight: true,
      autoclose: true,
      language: "ru"
  });