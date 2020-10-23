###########################################################################################################################################################
# Created By: Cyberhill Partners, LLC.
# https://cyberhillpartners.com
# Date: 10/15/2020
# Description: Active Licenses Inside Secret Server
###########################################################################################################################################################

Function Register-SSActivation {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $APIKey,
         [Parameter(Mandatory=$true, Position=2)]
         [string] $Name,
         [Parameter(Mandatory=$true, Position=3)]
         [string] $Phone,
         [Parameter(Mandatory=$true, Position=4)]
         [string] $email
    )
    
    $body = @{
        Name = $Name
        phoneNumber = $Phone
        email = $email
    };

    try
    {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Authorization", "Bearer $APIKey")

    $Activation = Invoke-RestMethod "$URI/api/v1/Activations" -Headers $headers -Body $body -Method Post
    return $Activation
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