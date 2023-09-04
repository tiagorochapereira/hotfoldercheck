#read configuration from Json file

try {
    $jsonConfigContents = Get-Content -Path "d:\Playground\VWFSPorto\Monitoring\Scripts\Hotfolder\hotfolder_monitor.json" -Raw
}
catch {
    Write-Error "There was an error accessing the configuration file.";
    Write-Output "The fiile should be on the same location as this script, and have the name \"hotfolder_monitor.json\".";
    Write-Output "Please check the path and try again.";
    Write-Error "Error: $($_.Exception.Message)";
}
#finally {
#    Write-Error "Well.. There was a really big error...";
#    Write-Error "Please read the following error message.";
#    Write-Error "Error: $($_.Exception.Message)";
#}


$config = ConvertFrom-Json $jsonConfigContents;

$volume = $config.hotfolder_config.volume;

Write-Output $volume;


foreach ($subfolder in $config.hotfolder_config.subfolder) {
    $monitor = $subfolder.monitor
    $files = Get-ChildItem -Path $($config.hotfolder_config.volume)+$($config.hotfolder_config.root)+$($subfolder.monitor);
    foreach ($file in $files) {
        Write-Output $file.Name
    }
}

