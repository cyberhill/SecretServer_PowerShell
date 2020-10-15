###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Search folders
###########################################################################################################################################################

Function Get-SSSearchFolders {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [int] $FolderTypeId,
         [Parameter(Mandatory=$False, Position=3)]
         [boolean] $ParentFolderId,
         [Parameter(Mandatory=$false, Position=4)]
         [string] $PermissionRequired,
         [Parameter(Mandatory=$False, Position=5)]
         [string] $SearchText,
         [Parameter(Mandatory=$False, Position=6)]
         [int] $Skip,
         [Parameter(Mandatory=$False, Position=7)]
         [string] $SortDirection,
         [Parameter(Mandatory=$False, Position=8)]
         [string] $SortField,
         [Parameter(Mandatory=$False, Position=9)]
         [int] $SortPriority,
         [Parameter(Mandatory=$False, Position=10)]
         [int] $Take = 10
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/folders?take=$take"
    
    If ($FolderTypeId) {
        $URI = "$URI&filter.folderTypeId=$FolderTypeId"
    } 

    If ($ParentFolderId) {
        $URI = "$URI&filter.parentFolderId=$parentFolderId"
    }

    If ($PermissionRequired) {
        $URI = "$URI&filter.permissionRequired=$PermissionRequired"
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
        Write-Host "ERROR: $($responseBody.error)"
        return;
    }
}