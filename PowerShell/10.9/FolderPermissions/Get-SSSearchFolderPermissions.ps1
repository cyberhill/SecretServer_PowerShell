###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 12/9/2020
# Description: Get folder permissions
###########################################################################################################################################################

Function Get-SSSearchFolderPermissions {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [int] $folderid,
         [Parameter(Mandatory=$False, Position=3)]
         [boolean] $groupId,
         [Parameter(Mandatory=$False, Position=4)]
         [boolean] $userid,
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
    $URI = "$URI/api/v1/folder-permissions?take=$take"
    
    If ($folderid) {
        $URI = "$URI&filter.folderId=$folderid"
    } 

    If ($userid) {
        $URI = "$URI&filter.userId=$userid"
    }

    If ($groupid) {
        $URI = "$URI&filter.groupid=$groupid"
    }

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