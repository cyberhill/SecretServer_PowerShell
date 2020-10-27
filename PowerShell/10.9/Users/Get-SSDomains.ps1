###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/26/2020
# Description: Get a list of Secret Server domains
###########################################################################################################################################################

Function Get-SSDomains {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [int] $Skip,
         [Parameter(Mandatory=$False, Position=3)]
         [string] $SortDirection,
         [Parameter(Mandatory=$False, Position=4)]
         [string] $SortField,
         [Parameter(Mandatory=$False, Position=5)]
         [int] $SortPriority,
         [Parameter(Mandatory=$False, Position=6)]
         [int] $Take = 10
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/domains?take=$take"
    
    If ($Skip) {
        $URI = "$URI&skip=$Skip"
    }

    If ($SortDirection) {
        $URI = "$URI&sortBy[0].direction=$SortDirection"
    }

    If ($SortField) {
        $URI = "$URI&sortBy[0].name=$SortField"
    }

    If ($SortPriority) {
        $URI = "$URI&sortBy[0].priority=$SortPriority"
    }
    
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
        Write-Host "ERROR: $($responseBody.error)"
        return;
    }
}