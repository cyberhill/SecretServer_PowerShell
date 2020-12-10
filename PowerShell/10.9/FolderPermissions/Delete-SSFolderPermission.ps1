###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 12/9/2020
# Description: Delete folder permission based on permission id
###########################################################################################################################################################

Function Delete-SSFolderPermission {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$False, Position=2)]
         [boolean] $breakInheritance,
         [Parameter(Mandatory=$True, Position=3)]
         [int] $id
    )

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")
    $URI = "$URI/api/v1/folder-permissions/$id"
    
    If ($breakinheritance) {
        $URI = $URI + "?breakinheritance=$breakInheritance"
    } 
    
    $secrets = Invoke-RestMethod $URI -Method Delete -Headers $headers
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