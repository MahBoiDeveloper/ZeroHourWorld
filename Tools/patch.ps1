param(
  [Parameter(Mandatory=$true, Position=0)]
  [string]$ScriptsPath,

  [Parameter(Mandatory=$true, Position=1)]
  [string]$PatchDescriptionPath
)

# Read files
$scriptsText = Get-Content -LiteralPath $ScriptsPath -Raw
$patchLines  = Get-Content -LiteralPath $PatchDescriptionPath

# Replacements
foreach ($line in $patchLines) 
{
  if ([string]::IsNullOrWhiteSpace($line)) { continue }

  $parts = $line.Split("///", 2)
  if ($parts.Count -ne 2)
  {
    throw "Некорректная строка патча (ожидался формат text///sample): $line"
  }

  $from = $parts[0]
  $to   = $parts[1]

  $escapedFrom = [Regex]::Escape($from)

  $scriptsText = [Regex]::Replace(
    $scriptsText,
    $escapedFrom,
    [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $to }
  )
}

# Write back
Set-Content -LiteralPath $ScriptsPath -Value $scriptsText -Encoding UTF8
