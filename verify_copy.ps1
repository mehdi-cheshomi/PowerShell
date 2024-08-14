# Define the source directory and the output file
$sourceDirectory = "D:\source\"
$source_outputFile = "d:\source_check.txt"

# Ensure the output file is cleared before writing
Clear-Content -Path $source_outputFile -ErrorAction SilentlyContinue

# Get all files in the source directory (recursively)
Get-ChildItem -Path $sourceDirectory -File -Recurse | ForEach-Object {
    # Compute the hash of the file
    $hash = Get-FileHash -Path $_.FullName -Algorithm SHA256
    # Format the output string
    $output = "{0}" -f $hash.Hash
    # Append the hash and file path to the output file
    Add-Content -Path $source_outputFile -Value $output
}

Write-Output "Hash checksums have been written to $outputFile"

# Define the source directory and the output file
$destDirectory = "D:\Destination"
$dest_outputFile = "d:\dest_check.txt"

# Ensure the output file is cleared before writing
Clear-Content -Path $dest_outputFile -ErrorAction SilentlyContinue

# Get all files in the source directory (recursively)
Get-ChildItem -Path $destDirectory -File -Recurse | ForEach-Object {
    # Compute the hash of the file
    $hash = Get-FileHash -Path $_.FullName -Algorithm SHA256
    # Format the output string
    $output = "{0}" -f $hash.Hash
    # Append the hash and file path to the output file
    Add-Content -Path $dest_outputFile -Value $output
}

Write-Output "Hash checksums have been written to $outputFile"

$sourceFile=$source_outputFile
$destinationFile=$dest_outputFile
$sourceHash = Get-FileHash -Path $sourceFile -Algorithm SHA256
$destinationHash = Get-FileHash -Path $destinationFile -Algorithm SHA256

# Compare hash values
if ($sourceHash.Hash -eq $destinationHash.Hash) {
    Write-Output "The files are identical."
} else {
    Write-Output "The files are different."
}