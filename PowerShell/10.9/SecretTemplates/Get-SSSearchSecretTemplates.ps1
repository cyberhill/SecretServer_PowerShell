###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Search Secret Templates
###########################################################################################################################################################

Function Get-SSSearchSecretTemplates {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [boolean] $includeInactive,
         [Parameter(Mandatory=$False, Position=3)]
         [boolean] $includeSecretCount,
         [Parameter(Mandatory=$False, Position=4)]
         [string] $searchText,
         [Parameter(Mandatory=$False, Position=5)]
         [int] $Skip,
         [Parameter(Mandatory=$False, Position=6)]
         [string] $SortDirection,
         [Parameter(Mandatory=$False, Position=7)]
         [string] $SortField,
         [Parameter(Mandatory=$False, Position=8)]
         [int] $SortPriority,
         [Parameter(Mandatory=$False, Position=9)]
         [int] $Take = 10
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/secret-templates?take=$take"
    
    If ($FolderTypeId) {
        $URI = "$URI&filter.includeInactive=$includeInactive"
    } 

    If ($ParentFolderId) {
        $URI = "$URI&filter.includeSecretCount=$includeSecretCount"
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

    $SecretTemplates = Invoke-RestMethod $URI -Method Get -Headers $headers
    return $SecretTemplates
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