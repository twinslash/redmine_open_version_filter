// this is patch for js function from core
function addFilter(field, operator, values) {
  var fieldId = field.replace('.', '_');
  var tr = $('#tr_'+fieldId);
  if (tr.length > 0) {
    tr.show();
  } else {
    // ========= patch start ============
    if ((field == 'in_open_versions') || (field == 'out_of_opened_versions')) {
      buildFilterRowPatch(field, operator, values);
    } else {
      buildFilterRow(field, operator, values);
    }
    // ========= patch end ============
  }
  $('#cb_'+fieldId).attr('checked', true);
  toggleFilter(field);
  $('#add_filter_select').val('').children('option').each(function(){
    if ($(this).attr('value') == field) {
      $(this).attr('disabled', true);
    }
  });
}

function buildFilterRowPatch(field, operator, values) {
  var fieldId = field.replace('.', '_');
  var filterTable = $("#filters-table");
  var filterOptions = availableFilters[field];

  var tr = $('<tr class="filter">').attr('id', 'tr_'+fieldId).html(
    '<td class="field"><input checked="checked" id="cb_'+fieldId+'" name="f[]" value="'+field+'" type="checkbox">' +
    '<label for="cb_'+fieldId+'"> '+filterOptions['name']+'</label></td>' +
    "<td class='operator'><input id='operators_#{field}' name=op['#{field}'] type=hidden ></td>" +
    '<td class="operator"></td>' +
    '<td class="values"></td>'
  );

  filterTable.append(tr);
}
