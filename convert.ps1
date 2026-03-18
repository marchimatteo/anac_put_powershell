# Load the JSON file
$json = Get-Content -Raw -Path "data.json" | ConvertFrom-Json

# Map the data to a flat structure
$results = $json.lista | ForEach-Object {
    $fine = $_.fine_contratto | Select-Object -First 1
    
    [PSCustomObject]@{
        _id                        = $_._id
        cig                        = $_.cig
        data_pubblicazione         = $_.data_pubblicazione
        oggetto                    = $_.oggetto
        importo                    = $_.importo
        DATA_EFFETTIVA_ULTIMAZIONE = $fine.DATA_EFFETTIVA_ULTIMAZIONE
        ID_AGGIUDICAZIONE          = $fine.ID_AGGIUDICAZIONE
        IMPORTO_SOMME_LIQUIDATE    = $fine.IMPORTO_SOMME_LIQUIDATE
    }
}

# Export to CSV (using semi-colon for Excel compatibility)
$results | Export-Csv -Path "output.csv" -NoTypeInformation -Delimiter ";" -Encoding utf8
Write-Host "Done! output.csv created."