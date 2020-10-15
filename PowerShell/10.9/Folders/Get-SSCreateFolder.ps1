###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Create a Folder
###########################################################################################################################################################

Function Get-SSCreateFolder {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [string] $FolderName,
         [Parameter(Mandatory=$true, Position=3)]
         [int] $FolderTypeId,
         [Parameter(Mandatory=$false, Position=4)]
         [boolean] $InheritPermissions = $true,
         [Parameter(Mandatory=$false, Position=5)]
         [boolean] $InheritSecretPolicy = $true,
         [Parameter(Mandatory=$true, Position=6)]
         [int] $ParentFolderId,
         [Parameter(Mandatory=$false, Position=7)]
         [int] $SecretPolicyId = '-1'
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")

    $body = @{
        FolderName = $FolderName
        FolderTypeId = $FolderTypeId
        InheritPermissions = $InheritPermissions
        InheritSecretPolicy = $InheritSecretPolicy
        ParentFolderId = $ParentFolderId
        SecretPolicyId = $SecretPolicyId
    }

    $CreateFolder = Invoke-RestMethod "$URI/api/v1/folders" -Method Post -Headers $headers -body $body
    return $CreateFolder
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