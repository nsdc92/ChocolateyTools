if($ENV:BHProjectName -and $ENV:BHProjectName.Count -eq 1)
{
    Deploy Module {
        By PSGalleryModule {
            FromSource $ENV:BHProjectName
            To PSGallery
            WithOptions @{
                ApiKey = "dac89b4c-a290-45aa-9cb1-7b16d3489505"
            }
        }
    }
}