# ForNYers

This app was designed by a New Yorker, for fellow New Yorkers. It's main functions are:

- A news reader (with news from NYT)
- A tip calculator
- A Metrocard refill calculator
- A steps calculator

The functions are divided by a tab bar controller. The user can switch between each function using the tab bar controller

Each function explained:

The news reader uses the NewsAPI.org API to get 10 articles from The New York Times. The articles are stored in Core Data
and displayed in a table view sorted by the date. If an internet connection is not available, it will show the news articles
from the most recent download.

The tip calculator lets the user enter the bill amount and select how much he/she wants to tip from a segment controller
(from 10% to 30%). In another segment controller, the user selects how many people to split the bill by (from 2 - 9 persons).

The Metrocard calculator lets the user enter the amount left in his/her Metrocard, and using the 11% bonus the MTA 
(Metropolitan Transit Authority) offers, calculates how much to have exact number of fares (without any change left) on their
card.

The steps calculator asks the user to enter the number of blocks and avenues he/she walked to estimate how many steps they
have taken. 


