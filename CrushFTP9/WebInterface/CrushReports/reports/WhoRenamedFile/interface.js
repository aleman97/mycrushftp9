/*Report interface*/
crushReports.reports.WhoRenamedFileTemplateFolder = "WhoDownloadedFile";
crushReports.isLoadingScript = true;
$.getScript("reports/WhoDownloadedFile/interface.js", function(){
    crushReports.reports.WhoRenamedFile = function(data, tpl) {
        crushReports.reports.WhoDownloadedFile(data, tpl, "rename");
    };
    crushReports.callbackOnReady();
    delete crushReports.callbackOnReady;
});