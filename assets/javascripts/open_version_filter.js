buildFilterRowWithoutOpenVersion = buildFilterRow;

function buildFilterRow(field, operator, values) {
  if ((field == 'in_open_versions') || (field == 'out_of_opened_versions')) {
    buildFilterRowWithOpenVersion(field, operator, values);
  } else {
    buildFilterRowWithoutOpenVersion(field, operator, values);
  }
}

function buildFilterRowWithOpenVersion(field, operator, values) {
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
