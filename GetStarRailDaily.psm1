Function Get-StarRailDaily {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [Int]$UserId,
        [Parameter(Mandatory = $true, Position = 1)]
        [String]$Token
    )
    $Url = "https://sg-public-api.hoyolab.com/event/luna/os/sign?act_id=e202303301540311"
    $Iwr = Invoke-WebRequest -Uri $Url -Method Post -Headers @{ Cookie = "ltuid=$UserId; ltoken=$Token" }
    # Get response
    $json = $Iwr.Content | ConvertFrom-Json
    # Export message from $json.message
    Switch ($json.retcode) {
        "0" { Write-Output $json.data.message }
        "-100" { Write-Error "Token expired, not logged in, or auth error" }
        "-5003" { Write-Error "You have already signed in today" }
        "-10001" { Write-Error "Invalid request" }
        Default { Write-Error "Unknown error: $($json.retcode) $($json.message)" }
    }
    <#
    .SYNOPSIS
    Get Star Rail Daily Reward from HoyoLab
    .DESCRIPTION
    Get Star Rail Daily Reward from HoyoLab. This function will return a message from the response.
    .PARAMETER UserId
    User ID from HoyoLab. You can grab this from your browser's cookie in Hoyolab: `ltuid`
    .PARAMETER Token
    Token from HoyoLab. You can grab this from your browser's cookie in Hoyolab: `ltoken`
    .EXAMPLE
    Get-StarRailDaily -UserId 123456789 -Token 123456789
    .EXAMPLE
    ggd -UserId 123456789 -Token 123456789
    .EXAMPLE
    daily -UserId 123456789 -Token 123456789
    .LINK
    https://github.com/qqii/GetStarRailDaily
    #>
}

Set-Alias -Name gsrd -Value Get-StarRailDaily
Set-Alias -Name daily -Value Get-StarRailDaily

# Export func and aliases
Export-ModuleMember -Function GetStarRailDaily -Alias ggd, daily
