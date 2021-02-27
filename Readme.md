# An Objective C app to show weather with suggestions.

This work is a take home test for iOS developer done by Mr. Ravi Bastola in Objective C. 

### Important
This app assumes and works on the premise that you have a working internet connection.

### Build Process:
I have used Xcode Version 12.2 (12B45b) to build and run this project hence Xcode greater than this should work and compile this project.

### Features:

1. Usage of Compositional Layout for collection views which does not have reference anywhere for its usage in Objective C.
2. Programmatic Layout for Views.
3. Used MVC pattern to architect the app.
4. Minimal Use of 3rd party libraries.

### Libraries Used:
1. [JG Progress HUD](https://github.com/JonasGessner/JGProgressHUD)
2. [Reachibility](https://github.com/tonymillion/Reachability)

### Testing Devices
This app can be tested on iPhone and only Potrait mode is supported.

### Extras

I wanted this task to have a good appeal of ux hence it took me more time  to create a suggestion table view <br/> 
which could load up the suggestions for countries from  remote web services while the user intends to type on the textfield. <br />
Unfortunately, I could not find such webservice which gives the name of countries and hence had to prepare a webservice with <br /> 
PostGres database having country names to search from. I also hosted my own <br>
[webservice](https://uxcam-api.herokuapp.com) which even filters the search results `https://uxcam-api.herokuapp.com?city=Ma` <br> 
but it was a bit cumbersome to debounce the <br> 
textfield's text typing which is easily handled in combine  and swift. Nevertheless, it was also a bit far fetched to insert a lot <br>
countries and their cities which open weather has hence I simply added a minimal list to show my capability. While there were a lot 
of libraries out in the wild to provide me with such feature I opted out to build it. However, it has some sort of shortcomings <br />
It was not practical to roundtrip everytime for each typed letter and hence I fetched the data at once and filtered it using string matching which 
in my opinion would have been better if  `Levenshtein distance` algorithm <br>
was applied as used in [MLPAutoCompleteTextField](https://github.com/EddyBorja/MLPAutoCompleteTextField) <br>
However, it was growing enormously so it had to omitted. I also thought to change background image of the location but it was <b
difficult to find high quality image for the city hence also omitted. I had also found a webservice which did that but the images were poor.


## License
[MIT](https://choosealicense.com/licenses/mit/)

