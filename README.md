# ASCustomBannerView

This is a banner with similar style to the App Store. It has auto-slide to left every 5 seconds and manual-slide to both sides.
It can be used quickly only by passing an array of images.

Lenguage: Swift 2

Author: Alan Roldan


Example:

<img src="GIF_ASCustomBannerView.gif" width="260">


Files:

1. Example_ASCustomBannerView: 
This is a example project.

2. ASCustomBannerView for Swift2: 
The files for use this template. you must move these files within your project.



How to use?

1. Create a variable of type BannerView:

    @IBOutlet weak var baner: BannerView!

2. Import images and create a array of images:

    let imagesArray = [String]()
    imagesArray = ["img1","img2","img3","img4"]

3. Get screen size width:

    let widthScreen = CGFloat()
    widthScreen = UIScreen.mainScreen().bounds.width

3. instantiate object:

    baner.createBanner(imagesArray, widthScreen: widthScreen)


<img src="http://www.floridauniversitaria.es/es-ES/noticias/PublishingImages/aviso_importante.png" width="30"> Images should be for proper operation of 720x300






