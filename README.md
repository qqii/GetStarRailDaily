<!-- omit in toc -->
# Star Rail Daily Login Claimer

*Claim your daily login rewards for [Star Rail](https://hsr.hoyoverse.com/en/) from [HoYoLAB](https://hoyolab.com) via PowerShell!*

<!-- omit in toc -->
## Table of Contents

- [About](#about)
- [Getting Started](#getting-started)
  - [Prerequisites (Install)](#prerequisites-install)
  - [Prerequisites (Configure)](#prerequisites-configure)
- [Usage](#usage)
- [A Warning To Those Who Use This](#a-warning-to-those-who-use-this)

## About

Tired of having to open the browser, navigate to HoYoLAB and click the claim
button every day? This PowerShell script will save you literally seconds of your
life!

## Getting Started

Nothing's free in life, and this script is no exception. To get started you'll
need to follow some instructions. Afterwards you'll have to use the spooky
hacker command line interface. Don't worry, it's not that scary.

### Prerequisites (Install)

1. Install PowerShell Core. Microsoft have pretty decent instructions
   [here](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.3).
2. Open PowerShell Core. You can find this in the start menu by searching for
   `pwsh`. It should look like this:  

<p align="center">
  <img src="./res/start_menu_powershell_core.png" alt="Opening powershell core via the start menu">
</p>

3. Copy `New-Item -Type File -Force $PROFILE && explorer.exe $PROFILE` into your
   PowerShell Core window and press enter. Magically Notepad will appear.
   _Spooky!_
4. Copy and paste the contents of [`GetStarRailDaily.ps1`](./GetStarRailDaily.ps1)
   into the Notepad window.

Don't close the Notepad window yet! We'll need to configure the script first.
You can close the PowerShell window though. We won't need it for a while.

### Prerequisites (Configure)

Now that you've got the script, we'll need to give it something called a cookie.
This is a magical ingredient that allows the script to log in to your account.
Make sure to keep it secret and ABSOLUTELY do not share it with anyone! I'm
serious. Don't do it.

Before we get your cookie, we'll need to add some of your own magical
incantations to the end of the spell (file).

```powershell
function daily {
    $_ = Get-StarRailDaily `
    -Cookie "<cookie>" `
    -UserAgent "<user agent>"

    return
}
```

It's not ready yet, so we'll need to get two ingredients. The cooking and the
user agent.

1. Go to [HoYoLAB](http://hoyolab.com) and log in to your account.
2. Press `F12` to open Developer Tools. _Ooooh, spooky hacker stuff!_
3. Type `copy(document.cookie)` into the console and press enter.
   It should say "String was copied to clipboard.", but if it doesn't try typing
   `document.cookie` and copy everything between the quotation marks.

<p align="center">
  <img src="./res/hoyolab_cookies.png" alt="Getting the HoYoLAB cookies from your browser, using the developer tools">
</p>

4. Replace the `<cookie>` part of the document we opened in Notepad. Leave the
   quotes.
5. [Google "my user agent" (or click me!)](https://www.google.com/search?q=my%20user%20agent)

<p align="center">
  <img src="./res/google_user_agent.png" alt="Google search of my user agent">
</p>

6. Copy and paste the user agent into the document, replacing `<user agent>`.
   Once again, don't you date touch those quotes

Your notepad document should end with something like this:

```powershell
function daily {
    $_ = Get-StarRailDaily `
    -Cookie "G_ENABLED_IDPS=google; ltoken=MY_TOKEN_NO_TAKE; ltuid=CHAMBER_OF_UIDS; cookie_token=OK_THEN_KEEP_YOUR_SECRETS; account_id=CAN_T_TOUCH_THIS; mi18nLang=en-us; _MHYUUID=I_M_RUNNING_OUT_OF_REFERENCES_HERE; DEVICEFP_SEED_ID=LIKE_WHAT_IS_EVEN_THIS_STTUFF; DEVICEFP_SEED_TIME=I_HAVE_NO_IDEA_TBH; DEVICEFP=BUT_IT_SEEMS_TO_WORK_SO___" `
    -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/113.0"

    return
}
```

7. Save and close the file. _If you're a 1337 hax0r like me you can press
   `Ctrl+S` and then `Alt+F4`._
8. If you haven't already, close that PowerShell window so we finish clean, as
    good magicians do. _(This step is important.)_

Well that was something. The runic incantations have been prepared and are
awaiting the magic incantation. Before that, let's take a break and admire our
work. Get a cup of coffee or something. You've earned it.

## Usage

Open PowerShell Core and type `daily`. Press enter. Give it a second. If you did
everything right, it should either say "Check in successful!" or "Already
checked in today.". 

If not then uh, try replacing the cookie with a fresh set after logging out and
back into Hoyolab. If that still doesn't work, create a github issue and I'll
try my best to help you out.

## A Warning To Those Who Use This

I take no responsibility of the security and safety of your account by using
this script. Definitely don't share your cookie with anyone, and do your due
diligence by reading [`GetStarRailDaily.ps1`](./GetStarRailDaily.ps1) to make
sure I'm not doing anything malicious. This script might also get your account
flagged or something. 

