# Speedy Pizza Web

## Introduction

Speedy Pizza is a restaurant based in Florence, Italy. Since 1997, the restaurant has relied on a strong, Java-powered PC application to handle food deliveries. I was hired by Speedy Pizza to recreate their software in a more modern and robust way, with a few adjustments and changes. The client needed an app that was similar to what they already had in use, in order to minimise staff re-training. 

## Table of Contents
* [Technologies](https://github.com/karimafas/speedypizza_web/blob/master/README.md#technologies)
* [Preview](https://github.com/karimafas/speedypizza_web/blob/master/README.md#preview)
* [Features](https://github.com/karimafas/speedypizza_web/blob/master/README.md#features)
  1. [Home](https://github.com/karimafas/speedypizza_web/blob/master/README.md#home)
  2. [Customer's Details](https://github.com/karimafas/speedypizza_web/blob/master/README.md#customers-details)
  3. [Order](https://github.com/karimafas/speedypizza_web/blob/master/README.md#order)
  4. [Review and Print](https://github.com/karimafas/speedypizza_web/blob/master/README.md#review-and-print)



## Technologies
* Flutter 1.25.0-8.3.pre
* Dart 2.12.0
* Firebase Firestore

## Preview
I have deployed an up-to-date version of this project. It's available [here](https://speedypizzaweb.web.app).
  
## Features

### Home
This is where the ordering process starts, with the customer's phone number as the key to access the ordering process.

### Customer's Details
After querying the database by phone number, the app pulls a specific customer's details, which can be edited at this stage. Once you press 'Next >', the database will be updated. 

### Order
The main ListView features the restaurant menu. Items can be chosen by inputting their unique product number (the client's preferred way as this is what they are used to), or by clicking on an item in the ListView. You can then change the quantity, and insert variations by code or by moving to the + tab in the top menu.

### Review and Print
On this screen, you are allowed to review your items. You can duplicate, delete or edit variations on any item. You can also go back and change the customers details. Before printing, you will be able to select a delivery time (your current accepted deliveries are also shown in the top left, in order to allow who's taking the order to make an educated decision and spread out deliveries during service).


