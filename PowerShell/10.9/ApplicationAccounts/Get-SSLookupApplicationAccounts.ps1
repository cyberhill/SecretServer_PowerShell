###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/30/2020
# Description: Lookup Application Account users
###########################################################################################################################################################

Function Get-SSLookupApplicationAccounts {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [boolean] $IncludeAll,
         [Parameter(Mandatory=$False, Position=3)]
         [string] $SearchText,
         [Parameter(Mandatory=$False, Position=4)]
         [int] $Skip,
         [Parameter(Mandatory=$False, Position=5)]
         [string] $SortDirection,
         [Parameter(Mandatory=$False, Position=6)]
         [string] $SortField,
         [Parameter(Mandatory=$False, Position=7)]
         [int] $SortPriority,
         [Parameter(Mandatory=$False, Position=8)]
         [int] $Take = 10
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/application-accounts/lookup?take=$take"
    
    If ($IncludeAll) {
        $URI = "$URI&filter.includeAll=$IncludeAll"
    } 

   If ($SearchText) {
        $URI = "$URI&filter.searchText=$SearchText"
    }

    If ($skip) {
        $URI = "$URI&skip=$skip"
    }

    If ($SortDirection) {
        $URI = "$URI&sortBy[n].direction=$SortDirection"
    }

    If ($SortField) {
        $URI = "$URI&sortBy[n].name=$SortField"
    }
    
    If ($SortPriority) {
        $URI = "$URI&sortBy[0].priority=$SortPriority"
    }

    $folders = Invoke-RestMethod $URI -Method Get -Headers $headers
    return $folders
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