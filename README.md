# BudgetGlobal

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview

### Description

BudgetGlobal is a versatile budget tracker and expense manager designed to simplify personal finance. Seamlessly integrate your spending habits across multiple currencies, stay on top of your daily expenses, and manage your budgets with intuitive visual tools. Whether you're tracking routine purchases at home or managing funds during international travel, BudgetGlobal is your go-to financial planner, making every penny count and helping you achieve financial control.

### App Evaluation

[Evaluation of your app across the following attributes]
- **Category:**
Finance & Travel
  
- **Mobile:**
Would incorporate local storage for quicker/offline access of finances
Could incorporate push notifications for reaching budget/completion of a week
could incorporate iOS widgets for better visibility on device

- **Story:**
App would allow for convinient tracking of daily expenses and budget
it is relevant to college students like my peers trying to manage their expenses in a simple/uncomplicated way
appeals to anyone looking to build a habit of maintaining a budget and keeping track of their expenses

- **Market:**
Targets a wide range of users of all ages
market is saturated with finance-tracking apps
clearly defined globally dispersed user base

- **Habit:**
users would open and interact with such an app daily to log expenses as they occur, check budgets regularly to stay within limits
app encourages active participation, as users need to input their spending and earnings data

- **Scope:**
scope of this app is well-defined with clear functionality aimed at managing personal finances
technical challenges might include implementing secure and accurate currency conversion APIs, user data privacy, and seamless synchronization
additional features like predictive analytics or customization options are planned as future enhancements.



## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can add/delete entries (income/expense)
* User can switch between currencies
* User can view week's summary
* User can set a budget and see progress towards it

**Optional Nice-to-have Stories**

* User can switch between weeks
* User can add expense/income categories
* User can view insights based on category

### 2. Screen Archetypes

- [ ] All entries screen
* add entry, remove entry
* clear all entries
* add budget
* switch currency

- [ ] Insights screen
* view week's total 
* view remaining budget

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* All entries
* Spending insights


**Flow Navigation** (Screen to Screen)

- [ ] editing entry info
* entry info page


## Wireframes

![wireframes](https://github.com/mihika0916/finalproject/assets/101855274/aefbf508-dd55-4064-b9ce-2f670d3d59d8)


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

Sprint 1, features implemented:
* [x] add/delete entries
* [x] change currency
* [x] view week's total      
<div>
    <a href="https://www.loom.com/share/ca9aac20f2ed41da9ca33ca50bca1148">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/ca9aac20f2ed41da9ca33ca50bca1148-with-play.gif">
    </a>
  </div>

Sprint 2, features implemented:
* [x] add budget
* [x] view budget remaining on insights view
* [x] clear week's entries     
<div>
    <a href="https://www.loom.com/share/d99787f74b754bb2bb0a20a6a2d6a432">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/d99787f74b754bb2bb0a20a6a2d6a432-with-play.gif">
    </a>
  </div>


Final Features implemented:
* [x] view detail view of each entry
* [x] edit name, value, notes of entry

  <div>
    <a href="https://www.loom.com/share/1379b062297043bc920d5d6737a2ffde">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/1379b062297043bc920d5d6737a2ffde-1713319989452-with-play.gif">
    </a>
  </div>




### Networking

- Main View Controller: Fetch latest currency exchange rates: Retrieves current exchange rates to update currency conversions in real-time.

