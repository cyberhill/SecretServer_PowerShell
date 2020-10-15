###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Do a health check of the application.  This is an un-authenticated call.
###########################################################################################################################################################

Function Get-SSHealthCheck {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI
    )

    try
    {

    $options = Invoke-RestMethod "$URI/api/v1/healthcheck" -Method Get
    return $options
    }
    catch
    {
        $result = $_.Exception.Response.GetResponseStream();
        $reader = New-Object System.IO.StreamReader($result);
        $reader.BaseStream.Position = 0;
        $reader.DiscardBufferedData();
        $responseBody = $reader.ReadToEnd() | ConvertFrom-Json
        Write-Host "ERROR: ($responseBody.error)"
        return;
    }
}