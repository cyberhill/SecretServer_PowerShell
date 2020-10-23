###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Change Unlimited Admin Mode
###########################################################################################################################################################

Function Update-SSConfigUnlimitedAdmin {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [boolean] $Enabled,
         [Parameter(Mandatory=$true, Position=3)]
         [string] $Notes
    )

    try
    {
    $Body = "{
        `"data`": {
            `"enabled`": {
                `"dirty`": `"True`",
                `"value`": `"$Enabled`"
            },
            `"notes`": {
                `"dirty`": `"True`",
                `"value`": `"$Notes`"
            }
        }
    }"

    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    $headers.Add("Authorization", "Bearer $APIKey")

    $ADSync = Invoke-RestMethod "$URI/api/v1/configuration/unlimited-admin" -Method Patch -Headers $headers -Body $Body
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