window.locale = {};
window.locale.en = {
    "emptyTable":     "No data available in table",
    "info":           "Showing _START_ to _END_ of _TOTAL_ entries",
    "infoEmpty":      "Showing 0 to 0 of 0 entries",
    "infoFiltered":   "(filtered from _MAX_ total entries)",
    "infoPostFix":    "",
    "infoThousands":  ",",
    "lengthMenu":     "Show _MENU_ entries",
    "loadingRecords": "Loading...",
    "processing":     "Processing...",
    "search":         "Search:",
    "zeroRecords":    "No matching records found",
    "paginate": {
        "first":    "First",
        "last":     "Last",
        "next":     "Next",
        "previous": "Previous"
    },
    "aria": {
        "sortAscending":  ": activate to sort column ascending",
        "sortDescending": ": activate to sort column descending"
    }
};

window.locale.uk = {
    "processing":   "Зачекайте...",
    "lengthMenu":   "Показати _MENU_ записів",
    "zeroRecords":  "Записи відсутні.",
    "info":         "Записи з _START_ по _END_ із _TOTAL_ записів",
    "infoEmpty":    "Записи з 0 по 0 із 0 записів",
    "infoFiltered": "(відфільтровано з _MAX_ записів)",
    "infoPostFix":  "",
    "search":       "Пошук:",
    "url":          "",
    "paginate": {
        "first": "Перша",
        "previous": "Попередня",
        "next": "Наступна",
        "last": "Остання"
    },
    "aria": {
        "sortAscending":  ": активувати для сортування стовпців за зростанням",
        "sortDescending": ": активувати для сортування стовпців за спаданням"
    }
};

window.locale.ru = {
  "processing": "Подождите...",
  "search": "Поиск:",
  "lengthMenu": "Показать _MENU_ записей",
  "info": "Записи с _START_ до _END_ из _TOTAL_ записей",
  "infoEmpty": "Записи с 0 до 0 из 0 записей",
  "infoFiltered": "(отфильтровано из _MAX_ записей)",
  "infoPostFix": "",
  "loadingRecords": "Загрузка записей...",
  "zeroRecords": "Записи отсутствуют.",
  "emptyTable": "В таблице отсутствуют данные",
  "paginate": {
    "first": "Первая",
    "previous": "Предыдущая",
    "next": "Следующая",
    "last": "Последняя"
  },
  "aria": {
    "sortAscending": ": активировать для сортировки столбца по возрастанию",
    "sortDescending": ": активировать для сортировки столбца по убыванию"
  }
};

window.dataTableLocale = function(){
    return window.locale[I18n.locale];
};
