// this is patch for js function from core
function addFilter(field, operator, values) {
  var fieldId = field.replace('.', '_');
  var tr = $('#tr_'+fieldId);
  if (tr.length > 0) {
    tr.show();
  } else {
    // ========= patch start ============
    if (field == 'from_versions_open_version_filter') {
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
  var filterValues = filterOptions['values'];
  var i, select;

  var tr = $('<tr class="filter">').attr('id', 'tr_'+fieldId).html(
    '<td class="field"><input checked="checked" id="cb_'+fieldId+'" name="f[]" value="'+field+'" type="checkbox"><label for="cb_'+fieldId+'"> '+filterOptions['name']+'</label></td>' +
    '<td class="values"></td>'
  );
  filterTable.append(tr);


  tr.find('td.values').append(
    '<span style="display:none;"><select class="value" id="values_'+fieldId+'_1" name="v['+field+'][]"></select>'
  );

  select = tr.find('td.values select');
  for (i=0;i<filterValues.length;i++){
    var filterValue = filterValues[i];
    var option = $('<option>');
    if ($.isArray(filterValue)) {
      option.val(filterValue[1]).text(filterValue[0]);
      if ($.inArray(filterValue[1], values) > -1) {option.attr('selected', true);}
    } else {
      option.val(filterValue).text(filterValue);
      if ($.inArray(filterValue, values) > -1) {option.attr('selected', true);}
    }
    select.append(option);
  }

}
