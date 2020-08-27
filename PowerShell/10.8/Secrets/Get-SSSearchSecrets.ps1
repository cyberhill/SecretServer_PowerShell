Function Get-SSSearchSecrets {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [boolean] $AllowDoubleLocks,
         [Parameter(Mandatory=$False, Position=3)]
         [boolean] $DoNotCalculateTotal,
         [Parameter(Mandatory=$False, Position=4)]
         [int] $DoubleLockID,
         [Parameter(Mandatory=$False, Position=5)]
         [string] $ExtendedFields,
         [Parameter(Mandatory=$False, Position=6)]
         [int] $ExtendedTypeId,
         [Parameter(Mandatory=$False, Position=7)]
         [int] $FolderID,
         [Parameter(Mandatory=$False, Position=8)]
         [string] $HeartbeatStatus,
         [Parameter(Mandatory=$False, Position=9)]
         [boolean] $includeActive,
         [Parameter(Mandatory=$False, Position=10)]
         [boolean] $includeInactive,
         [Parameter(Mandatory=$False, Position=11)]
         [boolean] $IncludeRestricted,
         [Parameter(Mandatory=$False, Position=12)]
         [boolean] $IncludeSubFolders,
         [Parameter(Mandatory=$False, Position=13)]
         [boolean] $IsExactMatch,
         [Parameter(Mandatory=$False, Position=14)]
         [boolean] $OnlyRPCEnabled,
         [Parameter(Mandatory=$False, Position=15)]
         [boolean] $OnlySharedWithMe,
         [Parameter(Mandatory=$False, Position=16)]
         [int] $PasswordTypeIds,
         [Parameter(Mandatory=$False, Position=17)]
         [string] $PermissionRequired,
         [Parameter(Mandatory=$False, Position=18)]
         [string] $Scope,
         [Parameter(Mandatory=$False, Position=19)]
         [string] $SearchField,
         [Parameter(Mandatory=$False, Position=20)]
         [string] $SearchFieldSlug,
         [Parameter(Mandatory=$False, Position=21)]
         [string] $SearchText,
         [Parameter(Mandatory=$False, Position=22)]
         [int] $SecretTemplateID,
         [Parameter(Mandatory=$False, Position=23)]
         [int] $SiteID,
         [Parameter(Mandatory=$False, Position=24)]
         [int] $Skip,
         [Parameter(Mandatory=$False, Position=25)]
         [string] $SortDirection,
         [Parameter(Mandatory=$False, Position=26)]
         [string] $SortField,
         [Parameter(Mandatory=$False, Position=27)]
         [int] $SortPriority,
         [Parameter(Mandatory=$False, Position=28)]
         [int] $Take = 10
    )
    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/secrets?take=$take"
    If ($AllowDoubleLocks) {
        $URI = "$URI&filter.allowDoubleLocks=$AllowDoubleLocks"
    } 
    If ($DoNotCalculateTotal) {
        $URI = "$URI&filter.doNotCalculateTotal=$DoNotCalculateTotal"
    }
    If ($DoubleLockID) {
        $URI = "$URI&filter.doubleLockId=$DoubleLockID"
    }
    If ($ExtendedFields) {
        $URI = "$URI&filter.filter.extendedFields=$ExtendedFields"
    }
    If ($ExtendedTypeId) {
        $URI = "$URI&filter.extendedTypeId=$ExtendedTypeId"
    }
    If ($FolderID) {
        $URI = "$URI&filter.folderId=$FolderID"
    }
    If ($HeartbeatStatus) {
        $URI = "$URI&filter.heartbeatStatus=$HeartbeatStatus"
    }
    If ($includeActive) {
        $URI = "$URI&filter.includeActive=$includeActive"
    }
    If ($includeInactive) {
        $URI = "$URI&filter.includeInactive=$includeInactive"
    }
    If ($IncludeRestricted) {
        $URI = "$URI&filter.includeRestricted=$IncludeRestricted"
    }
    If ($IncludeSubFolders) {
        $URI = "$URI&filter.includeSubFolders=$IncludeSubFolders"
    }
    If ($IsExactMatch) {
        $URI = "$URI&filter.isExactMatch=$IsExactMatch"
    }
    If ($OnlyRPCEnabled) {
        $URI = "$URI&filter.onlyRPCEnabled=$OnlyRPCEnabled"
    }
    If ($OnlySharedWithMe) {
        $URI = "$URI&filter.onlySharedWithMe=$OnlySharedWithMe"
    }
    If ($PasswordTypeIds) {
        $URI = "$URI&filter.passwordTypeIds=$PasswordTypeIds"
    }
    If ($PermissionRequired) {
        $URI = "$URI&filter.permissionRequired=$PermissionRequired"
    }
    If ($Scope) {
        $URI = "$URI&filter.scope=$Scope"
    }
    If ($SearchField) {
        $URI = "$URI&filter.searchField=$SearchField"
    }
    If ($SearchFieldSlug) {
        $URI = "$URI&filter.searchFieldSlug=$SearchFieldSlug"
    }
    If ($SearchText) {
        $URI = "$URI&filter.searchText=$SearchText"
    }
    If ($SecretTemplateID) {
        $URI = "$URI&filter.secretTemplateId=$SecretTemplateID"
    }
    If ($SiteID) {
        $URI = "$URI&filter.siteId=$SiteID"
    }
    Write-Host $URI
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
