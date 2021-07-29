var ss = SpreadsheetApp.getActiveSpreadsheet()
var sheet = ss.getSheets()[0]

function doGet(e) {
  var returnData = {}
  return ContentService.createTextOutput(JSON.stringify(returnData))
}

function doPost(e) {
  var data = JSON.parse(e.postData.contents)
  var returnData = {}
  if (data.token === getSecrets().token) {
    var date = new Date(data.timestamp * 1000)
    var locale = date.toLocaleString()
    sheet.appendRow([locale, data.download, data.upload])
    returnData.response = "success"
  } else {
    returnData.response = "token not recognized";
  }
  
  return ContentService.createTextOutput(JSON.stringify(returnData))
}
