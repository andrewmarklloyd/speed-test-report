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
    var downloadMB = formatBytes(data.download)
    var uploadMB = formatBytes(data.upload)
    sheet.appendRow([locale, downloadMB, uploadMB])
    returnData.response = "success"
  } else {
    returnData.response = "token not recognized";
  }

  return ContentService.createTextOutput(JSON.stringify(returnData))
}

function formatBytes(bytes, decimals = 2) {
  if (bytes === 0) return 0

  const k = 1024
  const dm = decimals < 0 ? 0 : decimals
  const i = Math.floor(Math.log(bytes) / Math.log(k))

  return parseFloat((bytes / Math.pow(k, i)).toFixed(dm))
}
