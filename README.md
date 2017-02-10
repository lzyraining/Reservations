# Reservations

The Assessment is written in Swift 3.0 and can be run in Xcode 8.

Implementation Deatils

  *Splash Screen
   
 *My Reservation Screen
   
 1)Embed a table view which has a static cell as a template in section 1 and dynamic cell with info from coredata in section 2

*Service Screen

 1)An infinite scrollable collectionView
 2)A Static table view
 3)Asynchronized image downloading task. (I use apple built URLSession class, I can also using Alamofire)
 
 *Reservation Screen
 1)A Static label would display the service information 2)A calendar collection view displays the days of current month
 3)A collection view diplays the available time 4)A picker view would display when user clicks party size
 
TODO List: 

1) Enable the button of my reservation screen. Delete data in core data for cancel button. Share reservation data to Schedule Screen to
resave it into coredata with the same reservationID.
2) Use the third party library framwork like JTAppleCalendar implement Calendar
3) Disable the calendar cells with dates that are past the current date
4) Disable the time cell where time is already picked
5) create custom view with .xib file to make views resuable 
   
    
