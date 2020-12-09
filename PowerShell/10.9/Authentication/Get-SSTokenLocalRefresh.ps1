###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 12/9/2020
# Description: Use Refresh token to get new bearer token.
###########################################################################################################################################################

Function Get-SSTokenLocalRefresh {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [String] $APIRefreshKey
    )

    try
    {

    $Body = @{
        refresh_token = $APIRefreshKey
        grant_type = "refresh_token"
    };
    
    $secrets = Invoke-RestMethod "$URI/oauth2/token" -Method Post -Body $Body
    return $secrets
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