###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 12/9/2020
# Description: Launch a Launcher from a secret
###########################################################################################################################################################

Function Get-SSLaunchSecret {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [int] $launcherID,
         [Parameter(Mandatory=$false, Position=3)]
         [string] $promptFieldValue,
         [Parameter(Mandatory=$false, Position=4)]
         [string] $SecretId,
         [Parameter(Mandatory=$false, Position=5)]
         [string] $siteID
    )
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")

    $Body = @{
        launcherId = $launcherID
        promptFieldValue = $promptFieldValue
        secretId = $SecretId
        siteId = $siteID
    };

    try
    {
        $response = Invoke-RestMethod "$URI/api/v1/launchers/secret" -Method Post -Body $Body -Headers $headers;
        return $response;
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