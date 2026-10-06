$ErrorActionPreference = "Continue"
$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$gh = "C:\Users\fangfang\AppData\Local\GitHubDesktop\GitHubDesktop.exe"
$site = "https://2398532573-a11y.github.io/pypath-cn/"

Write-Host "正在打开 GitHub Desktop..." -ForegroundColor Cyan
if (Test-Path -LiteralPath $gh) {
    cmd /c start "" "$gh" --cli-open "$repo"
} else {
    Write-Host "找不到 GitHub Desktop：$gh" -ForegroundColor Red
    Read-Host "按回车退出"
    exit 1
}

Start-Sleep -Seconds 6
Write-Host "正在寻找 Push origin 按钮..." -ForegroundColor Cyan
Add-Type -AssemblyName UIAutomationClient,UIAutomationTypes
$root = [System.Windows.Automation.AutomationElement]::RootElement
$buttons = $root.FindAll([System.Windows.Automation.TreeScope]::Descendants,[System.Windows.Automation.Condition]::TrueCondition)
$pushButton = $null
foreach ($el in $buttons) {
    try {
        if ($el.Current.ControlType -eq [System.Windows.Automation.ControlType]::Button -and $el.Current.Name -match "Push origin") {
            $pushButton = $el
            break
        }
    } catch {}
}
if ($pushButton) {
    try {
        $pattern = $pushButton.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern)
        $pattern.Invoke()
        Write-Host "已点击 Push origin，等待上传..." -ForegroundColor Green
        Start-Sleep -Seconds 18
    } catch {
        Write-Host "自动点击失败，请手动点 Push origin。" -ForegroundColor Yellow
        Start-Sleep -Seconds 4
    }
} else {
    Write-Host "没自动找到 Push origin，请手动点右上角蓝色按钮。" -ForegroundColor Yellow
    Start-Sleep -Seconds 5
}
Write-Host "正在打开网站..." -ForegroundColor Cyan
cmd /c start "" "$site"
Write-Host "如果还是旧版，请按 Ctrl + F5。" -ForegroundColor Cyan
Start-Sleep -Seconds 2