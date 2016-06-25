# ASCustomBannerView

This is a banner with similar style to the App Store.

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

How to use?

1. Create a variable of type windowView():
let window = windowView()

2. Import images and create a array of images:
let imagesArray = [String]()
imagesArray = ["img1","img2","img3","img4"]

3. Create a array of titles:
let titlesArray = [String]()
titlesArray = ["title of image 1","title of image 2","title of image 3","title of image 4"]

4. instantiate object:
window.modelTwo(self, arrayImages: self.imagesArray, arrayTitles: self.titlesArray)


<img src="http://www.floridauniversitaria.es/es-ES/noticias/PublishingImages/aviso_importante.png" width="30"> Images should be for proper operation of 720x300






