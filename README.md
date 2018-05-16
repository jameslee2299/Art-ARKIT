# Art-ARKIT

This is a augmented reality airplane shooter game.

Minimum to run 
-Mac computer (updated to use High Sierra) 
This can be found in the apple icon (at the top left of your Mac) > About this Mac  (If not you’ll need to do a software update)
-Iphone 7 or above. The AR app is NOT supported for Samsung or iPhone 6 / below 

STEPS
1. Download Xcode link: https://developer.apple.com/download/
2. Navigate to planeShooterGame > planeShooterGame.xcodeproj
3. Navigate to the General tab (at the top)
4. Click Team list dropdown and “Add an Account”
5. Sign into your apple account
6. Connect your phone to your laptop 
7. At the top near the play icon / stop icon, it’ll say planeShooterGame > iPhone 8 (or some other version similar to that)
8. Click the iPhone 8 and change it to iPhone (near the top under device)
9. Change your unique Bundle Identifier to <unique_string>.plane-shooter
    a. Ie. I used “federal-way-wa.plane-shooter" (yours must be DIFFERENT. If you choose one that’s pre-existing it’ll throw an error)
10. Click “Try Again” under the Failed to create provisioning profile error 
    a. If instead of the error you see “Signing Certificate” iPhone Developer:<your_email> proceed to the next step
11. It should now say Signing Certificate : iPhone Developer: <your_email>
    a. If the error message still persists despite following the above steps try clicking Team > “Add an Account” > CANCEL
        i. When prompted to sign in click cancel such that you can see the accounts you’ve already registered
        ii. Navigate to your specific Apple ID you plan to use on the left side
        iii. Click Manage Certificates > “+” (on the bottom left) > iOS Development
12. Click the play icon at the top left of the page
13. If the error message “Could not launch “planeShooterGame”” shows then follow the steps as it specifies 
    a. These steps are to Open Settings on the iPhone > General > Device Management > (your_email) > “Trust jameslee2299@gmail.com”

CREDITS:
Alien artwork: alban @ sketchfab
Airplane artwork: Sender Pinarci @ TurboSquid
