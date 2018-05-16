if($ENV:BHProjectName -and $ENV:BHProjectName.Count -eq 1)
{
    Deploy Module {
        By PSGalleryModule {
            FromSource $ENV:BHProjectName
            To PSGallery
            WithOptions @{
                ApiKey = gXD4c5l8xUJRlQt5oqbMauiSY6vSlAQ9y8hyR2FO10jTl+nwkAR/SEOLxxLPbN+o
            }
        }
    }
}