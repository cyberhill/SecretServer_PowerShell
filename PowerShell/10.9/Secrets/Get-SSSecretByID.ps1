###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Get the secret by ID
###########################################################################################################################################################

Function Get-SSSecretByID {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [int] $SecretID,
         [Parameter(Mandatory=$false, Position=3)]
         [string] $IncludeInactive = $false
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")

    $URL = "$URI/api/v1/secrets/$SecretID" + "?IncludeInactive=$IncludeInactive"

    $SecretDetails = Invoke-RestMethod $URL -Headers $headers
    return $SecretDetails
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