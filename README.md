# ImageSlider
Simple images slider

![Alt text](https://github.com/datle021194/ImageSlider/blob/master/image1.png?raw=true "example 1")
![Alt text](https://github.com/datle021194/ImageSlider/blob/master/image2.png?raw=true "example 2")

# Usage Example
```swift
let vc = SimpleImageSlider()
vc.images = ["test1", "test2", "test3"]
self.navigationController?.pushViewController(vc, animated: true)
```
# Custom indicator color
```swift
let vc = SimpleImageSlider()
vc.images = ["test1", "test2", "test3"]
vc.indicatorColor = UIColor.red
vc.currentIndicatorColor = UIColor.black
self.navigationController?.pushViewController(vc, animated: true)
```
