###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/26/2020
# Description: Get Secret Server user by ID
###########################################################################################################################################################

Function Get-SSUserById {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [int] $UserID,
         [Parameter(Mandatory=$False, Position=3)]
         [boolean] $includeInactive = $False
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/users/$UserID" + "?" + "includeInactive=$includeInactive"
    
    $secrets = Invoke-RestMethod $URI -Method Get -Headers $headers
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