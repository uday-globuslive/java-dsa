# Simple PowerShell script to check for broken internal markdown links

$WorkspaceRoot = "c:\Users\vmadmin\Desktop\dsa"
$BrokenLinks = @()

# Get all markdown files
$MarkdownFiles = Get-ChildItem -Path $WorkspaceRoot -Filter "*.md" -Recurse

Write-Host "Checking internal links in $($MarkdownFiles.Count) markdown files..."

foreach ($file in $MarkdownFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $relativePath = $file.FullName.Replace($WorkspaceRoot, "").Replace("\", "/").TrimStart("/")
    
    # Find markdown links [text](path) - simple regex
    $pattern = '\[([^\]]*)\]\(([^)]+)\)'
    $matches = [regex]::Matches($content, $pattern)
    
    foreach ($match in $matches) {
        $linkText = $match.Groups[1].Value
        $linkPath = $match.Groups[2].Value
        
        # Skip external links and anchors
        if ($linkPath -match '^https?://' -or $linkPath -match '^#') {
            continue
        }
        
        # Handle relative paths
        $targetPath = ""
        if ($linkPath.StartsWith('./')) {
            $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPath.Substring(2)
        } elseif ($linkPath.StartsWith('../')) {
            $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPath
        } elseif ($linkPath.StartsWith('/')) {
            $targetPath = Join-Path -Path $WorkspaceRoot -ChildPath $linkPath.TrimStart('/')
        } else {
            $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $linkPath
        }
        
        # Remove anchor fragment if present
        if ($linkPath.Contains('#')) {
            $pathWithoutAnchor = $linkPath.Split('#')[0]
            if ($pathWithoutAnchor.StartsWith('./')) {
                $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $pathWithoutAnchor.Substring(2)
            } elseif ($pathWithoutAnchor.StartsWith('../')) {
                $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $pathWithoutAnchor
            } elseif ($pathWithoutAnchor.StartsWith('/')) {
                $targetPath = Join-Path -Path $WorkspaceRoot -ChildPath $pathWithoutAnchor.TrimStart('/')
            } else {
                $targetPath = Join-Path -Path $file.Directory.FullName -ChildPath $pathWithoutAnchor
            }
        }
        
        # Normalize path
        try {
            $targetPath = [System.IO.Path]::GetFullPath($targetPath)
        } catch {
            $targetPath = $targetPath
        }
        
        # Check if target exists
        if (-not (Test-Path -Path $targetPath)) {
            $relativeTargetPath = $targetPath.Replace($WorkspaceRoot, "").Replace("\", "/").TrimStart("/")
            $BrokenLinks += @{
                SourceFile = $relativePath
                LinkText = $linkText
                LinkPath = $linkPath
                TargetPath = $relativeTargetPath
            }
        }
    }
}

if ($BrokenLinks.Count -eq 0) {
    Write-Host "No broken internal links found!" -ForegroundColor Green
} else {
    Write-Host "Found $($BrokenLinks.Count) broken internal links:" -ForegroundColor Red
    foreach ($link in $BrokenLinks) {
        Write-Host "Source: $($link.SourceFile)" -ForegroundColor Yellow
        Write-Host "  Link: [$($link.LinkText)]($($link.LinkPath))" -ForegroundColor White
        Write-Host "  Missing: $($link.TargetPath)" -ForegroundColor Red
        Write-Host ""
    }
}
