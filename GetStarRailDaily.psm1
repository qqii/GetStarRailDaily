function Get-StarRailDaily {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [String]$Cookie,
        [Parameter(Position = 1)]
        [String]$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0"
    )
    $Headers = @{
        "Cookie"          = $Cookie
        "Accept-Encoding" = "gzip, deflate, br"
        "Referer"         = "https://act.hoyolab.com"
    }

    $ActId = "e202303301540311"
    $InfoUrl = "https://sg-public-api.hoyolab.com/event/luna/os/info?act_id=${ActId}"
    $RewardUrl = "https://sg-public-api.hoyolab.com/event/luna/os/home?act_id=${ActId}"
    $SignUrl = "https://sg-public-api.hoyolab.com/event/luna/os/sign?act_id=${ActId}"

    $Info = Invoke-RestMethod -Method Get -Uri $InfoUrl `
        -UserAgent $UserAgent `
        -Headers $Headers

    if ($Info.retcode -ne 0) {
        Write-Error "Error: $($Info.retcode) $($Info.message)"
        Write-Error "Try to update your cookie and user agent."
        return
    }

    $Rewards = (Invoke-RestMethod -Method Get -Uri $RewardUrl `
            -UserAgent $UserAgent `
            -Headers $Headers).data.awards

    $CheckIn = Invoke-RestMethod -Method Post -Uri $SignUrl `
        -UserAgent $UserAgent `
        -Headers $Headers

    $Reward = $Rewards[$Info.data.total_sign_day - 1]
    $Claimed = "You claimed: $($Reward.name) x$($Reward.count)"
    $Streak = "Your streak is: $($Info.data.total_sign_day)"

    switch ($CheckIn.retcode) {
        "0" {
            Write-Output "Check in successful!"
            Write-Output $Claimed
            Write-Output $Streak
        }
        "-5003" {
            Write-Warning "You have already checked in in today."
            Write-Warning $Claimed
            Write-Warning $Streak
        }
        Default {
            Write-Error "Error: $($Info.retcode) $($Info.message)"
            Write-Error "Try to update your cookie and user agent."
        }
    }

    return $CheckIn

    <#
    .SYNOPSIS
    Get Star Rail Daily Reward from HoyoLab
    .DESCRIPTION
    Get Star Rail Daily Reward from HoyoLab. This function will return the
    response from checking in.
    .PARAMETER Cookie
    Cookie from Hoyolab. This must include `ltoken` and `ltuid`.
    .PARAMETER UserAgent
    Browser user agent. This will default to Firefox 113.0, but it is
    reccomended to set this to your own browser.
    .EXAMPLE
    Get-StarRailDaily -Cookie "ltoken=qmzEqFTK4SLUs9kz7FjHFMYxlea2jzwHzSGxOl4D; ltuid=331575279" -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0"
    .LINK
    https://github.com/qqii/GetStarRailDaily
    #>
}

# Export function
Export-ModuleMember -Function GetStarRailDaily
