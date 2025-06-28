# PowerShell script to check for broken internal markdown links

$WorkspaceRoot = "c:\Users\vmadmin\Desktop\dsa"
$BrokenLinks = @()

# Get all markdown files
$MarkdownFiles = Get-ChildItem -Path $WorkspaceRoot -Filter "*.md" -Recurse

Write-Host "🔍 Checking internal links in $($MarkdownFiles.Count) markdown files..." -ForegroundColor Cyan

foreach ($file in $MarkdownFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $relativePath = $file.FullName.Replace($WorkspaceRoot, "").Replace("\", "/").TrimStart("/")
    
    # Find markdown links [text](path)
    $matches = [regex]::Matches($content, '\[([^\]]*)\]\(([^)]+)\)')
    
    foreach ($match in $matches) {
        $linkText = $match.Groups[1].Value
        $linkPath = $match.Groups[2].Value
        
        # Skip external links, anchors, and empty links
        if ($linkPath -match '^https?://' -or $linkPath -match '^#' -or [string]::IsNullOrWhiteSpace($linkPath)) {
            continue
        }
        
        # Resolve relative path
        if ($linkPath.StartsWith('./') -or $linkPath.StartsWith('../')) {
            $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPath
        } elseif ($linkPath.StartsWith('/')) {
            $targetPath = Join-Path -Path $WorkspaceRoot -ChildPath $linkPath.TrimStart('/')
        } else {
            $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPath
        }
        
        # Normalize path
        $targetPath = [System.IO.Path]::GetFullPath($targetPath)
        
        # Remove anchor if present
        if ($linkPath.Contains('#')) {
            $linkPathNoAnchor = $linkPath.Split('#')[0]
            if ($linkPathNoAnchor.StartsWith('./') -or $linkPathNoAnchor.StartsWith('../')) {
                $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPathNoAnchor
            } elseif ($linkPathNoAnchor.StartsWith('/')) {
                $targetPath = Join-Path -Path $WorkspaceRoot -ChildPath $linkPathNoAnchor.TrimStart('/')
            } else {
                $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPathNoAnchor
            }
            $targetPath = [System.IO.Path]::GetFullPath($targetPath)
        }
        
        # Check if target exists
        if (-not (Test-Path -Path $targetPath)) {
            $BrokenLinks += [PSCustomObject]@{
                SourceFile = $relativePath
                LinkText = $linkText
                LinkPath = $linkPath
                TargetPath = $targetPath.Replace($WorkspaceRoot, "").Replace("\", "/").TrimStart("/")
            }
        }
    }
}

if ($BrokenLinks.Count -eq 0) {
    Write-Host "✅ No broken internal links found!" -ForegroundColor Green
} else {
    Write-Host "❌ Found $($BrokenLinks.Count) broken internal links:" -ForegroundColor Red
    foreach ($link in $BrokenLinks) {
        Write-Host "  📄 $($link.SourceFile)" -ForegroundColor Yellow
        Write-Host "     🔗 [$($link.LinkText)]($($link.LinkPath))" -ForegroundColor White
        Write-Host "     ❌ Target not found: $($link.TargetPath)" -ForegroundColor Red
        Write-Host ""
    }
}
