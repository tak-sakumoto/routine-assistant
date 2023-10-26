function generateRandomString(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return result;
}

function generateTable(rowNum, colNum, strLength) {
    function createTableElement(tag, innerHTML) {
        var element = document.createElement(tag);
        element.innerHTML = innerHTML;
        return element;
    }

    var table = document.createElement('table');

    var headerRow = document.createElement('tr');
    headerRow.appendChild(createTableElement('th', ''));
    for (var j = 0; j < colNum; j++) {
        headerRow.appendChild(createTableElement('th', j));
    }
    table.appendChild(headerRow);

    for (var i = 0; i < rowNum; i++) {
        var row = document.createElement('tr');
        row.appendChild(createTableElement('th', i));
        for (var j = 0; j < colNum; j++) {
            row.appendChild(createTableElement('td', "(" + i + "," + j + ") " + generateRandomString(strLength)));
        }
        table.appendChild(row);
    }
    document.getElementById('tableContainer').appendChild(table);
}

window.onload = function() {
    generateTable(8, 8, 10);
};
