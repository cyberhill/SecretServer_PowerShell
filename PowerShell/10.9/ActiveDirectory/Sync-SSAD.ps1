﻿###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 2/10/2021
# Description: Syncronize Active Directory with Secret Server
###########################################################################################################################################################

Function Sync-SSAD {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    

    $ADSync = Invoke-RestMethod "$URI/api/v1/active-directory/synchronize" -Method Post -Headers $headers
    return $ADSync
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