function Open-PDF {
    param (
        [byte[]]$PdfBytes
    )

    try {
        $tempFilePath = [System.IO.Path]::GetTempFileName() + ".pdf"
        [System.IO.File]::WriteAllBytes($tempFilePath, $PdfBytes)
        Start-Process $tempFilePath
    }
    catch {
        Write-Host "Error opening the PDF: $_"
    }
}

# Example usage:
# $pdfBytes = [System.IO.File]::ReadAllBytes("C:\Path\To\Your\File.pdf")
# Open-PDFWithDefaultViewer -PdfBytes $pdfBytes