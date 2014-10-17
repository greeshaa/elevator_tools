$(document).ready ->
  $(".datatable").dataTable
    bdeferRender: true
    sDom: "frtiS"
    scrollY: "555px"
    scrollCollapse: true
    stateSave: true

    language:
      sSearch: "Поиск "
      sInfo:   "Строки с _START_ до _END_ из _TOTAL_ "
      sZeroRecords: "Строки отсутствуют"
      sInfoEmpty:   ""
      sInfoFiltered: "(отфильтровано из _MAX_ строк)"
  return