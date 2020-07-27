# The URI is the URL for the application
# The OTP is a One Time Password for those that have TOTP or Radius Authentication turned on

Function Get-SSTokenLocal {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $URI,
         [Parameter(Mandatory=$true, Position=1)]
         [string] $UserName,
         [Parameter(Mandatory=$true, Position=2)]
         [string] $Password,
         [Parameter(Mandatory=$false, Position=3)]
         [string] $OTP
    )

    $creds = @{
        username = $UserName
        password = $Password
        grant_type = "password"
    };

    $headers = $null
    If ($OTP) {
        $headers = @{
            "OTP" = $OTP
        }
    }

    try
    {
        $response = Invoke-RestMethod "$URI/oauth2/token" -Method Post -Body $creds -Headers $headers;
        return $response;
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