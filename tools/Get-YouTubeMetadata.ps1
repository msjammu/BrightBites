function Get-YouTubeMetadata {
    param(
        [Parameter(Mandatory=$true)]
        [string]$VideoUrl
    )
    
    # Extract video ID from URL if full URL is provided
    if ($VideoUrl -match "(?:youtube\.com/watch\?v=|youtu\.be/)([a-zA-Z0-9_-]+)") {
        $videoId = $matches[1]
    } else {
        # Assume it's already just the video ID
        $videoId = $VideoUrl
    }
    
    Write-Host "Fetching metadata for YouTube video: $videoId" -ForegroundColor Yellow
    
    try {
        # Make the web request
        $response = Invoke-WebRequest -Uri "https://www.youtube.com/watch?v=$videoId" -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -ErrorAction Stop
        
        # Extract metadata using regex patterns
        $title = ($response.Content | Select-String -Pattern '"title":"([^"]+)"' | ForEach-Object { $_.Matches[0].Groups[1].Value })
        $channel = ($response.Content | Select-String -Pattern '"channelName":"([^"]+)"' | ForEach-Object { $_.Matches[0].Groups[1].Value })
        $uploadDate = ($response.Content | Select-String -Pattern '"uploadDate":"([^"]+)"' | ForEach-Object { $_.Matches[0].Groups[1].Value })
        $description = ($response.Content | Select-String -Pattern '"description":"([^"]+)"' | ForEach-Object { $_.Matches[0].Groups[1].Value })
        
        # Format the date for consistency (YYYY-MM-DD)
        $formattedDate = ""
        if ($uploadDate) {
            try {
                $dateObj = [DateTime]::Parse($uploadDate)
                $formattedDate = $dateObj.ToString("yyyy-MM-dd")
            } catch {
                $formattedDate = $uploadDate.Split('T')[0]  # Fallback to just the date part
            }
        }
        
        # Create metadata object
        $metadata = @{
            Title = $title
            Channel = $channel
            UploadDate = $uploadDate
            FormattedDate = $formattedDate
            VideoId = $videoId
            ThumbnailUrl = "https://i.ytimg.com/vi/$videoId/hqdefault.jpg"
            Description = $description
        }
        
        return $metadata
        
    } catch {
        Write-Error "Failed to fetch metadata: $_"
        return $null
    }
}

function Format-YouTubeDataJsEntry {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$Metadata,
        [string[]]$Tags = @()
    )
    
    $title = $Metadata.Title -replace "'", "\'"  # Escape single quotes for JavaScript
    
    $entry = @"
  {
    type: 'video',
    title: '$title',
    youtubeId: '$($Metadata.VideoId)',
    channel: '$($Metadata.Channel)',
    date: '$($Metadata.FormattedDate)',
    image: '$($Metadata.ThumbnailUrl)',
    tags: [$($Tags | ForEach-Object { "'$_'" } | Join-String -Separator ', ')]
  }
"@
    
    return $entry
}

function Add-YouTubeVideoToData {
    param(
        [Parameter(Mandatory=$true)]
        [string]$VideoUrl,
        [string[]]$Tags = @(),
        [switch]$ShowMetadataOnly
    )
    
    # Get metadata
    $metadata = Get-YouTubeMetadata -VideoUrl $VideoUrl
    
    if (-not $metadata) {
        Write-Error "Could not retrieve metadata for video: $VideoUrl"
        return
    }
    
    # Display metadata
    Write-Host "`nYouTube Video Metadata:" -ForegroundColor Green
    Write-Host "Title: $($metadata.Title)" -ForegroundColor Cyan
    Write-Host "Channel: $($metadata.Channel)" -ForegroundColor Cyan
    Write-Host "Upload Date: $($metadata.UploadDate)" -ForegroundColor Cyan
    Write-Host "Formatted Date: $($metadata.FormattedDate)" -ForegroundColor Cyan
    Write-Host "Video ID: $($metadata.VideoId)" -ForegroundColor Cyan
    Write-Host "Thumbnail: $($metadata.ThumbnailUrl)" -ForegroundColor Cyan
    
    if ($metadata.Description) {
        $shortDesc = if ($metadata.Description.Length -gt 100) { $metadata.Description.Substring(0, 100) + "..." } else { $metadata.Description }
        Write-Host "Description: $shortDesc" -ForegroundColor Cyan
    }
    
    if ($ShowMetadataOnly) {
        return $metadata
    }
    
    # Generate data.js entry
    $entry = Format-YouTubeDataJsEntry -Metadata $metadata -Tags $Tags
    
    Write-Host "`nGenerated data.js entry:" -ForegroundColor Green
    Write-Host $entry -ForegroundColor White
    
    return @{
        Metadata = $metadata
        DataJsEntry = $entry
    }
}

# Example usage:
# Add-YouTubeVideoToData -VideoUrl "https://www.youtube.com/watch?v=5XhxR9Vs6zc" -Tags @('github-pages', 'tutorial', 'deployment')
# Get-YouTubeMetadata -VideoUrl "5XhxR9Vs6zc"