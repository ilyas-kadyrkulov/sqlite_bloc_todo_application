# Simpliest ToDo Application

![screen1](https://i.imgur.com/m5aycC2.png)

## Features
- Bloc template
- SQLite DB for flutter *sqflite*
- SOLID
- Null safety

### Plugins used
- **datetime_picker_formfield** - for interactivity, when choosing the date.
 
![datetime_picker](https://i.imgur.com/EKWIKEj.png)

- **intl** - to define DateFormat to be *day-month-year*.

- **uuid** - used to generate v4 (random) global identifiers for ToDos.

- **provider** - transfers the stored values. So, there is a stream of ToDos' List, which we get with *todoStream* getter, and later use in the **StreamBuilder**.
![stream](https://i.imgur.com/qgd8IDe.png)
![streambuilder](https://i.imgur.com/nFFisNV.png)

- **path_provider** - you can easily find the most used locations on the filesystem of the device. So, *documentsDirectory* variable gives path to the directory where Application can place its private files.
![path_provider](https://i.imgur.com/hZ6PSqj.png)

## Unfortunately, I haven't managed to publish it on Github Pages, there's some sticky annoying error with plugins.

## Some functions:
### Creating/updating
![create/update](https://i.imgur.com/Y0osnPv.png)

### Deleting using Dismissible()
![delete](https://i.imgur.com/3B2cYnB.png)
![delete](https://i.imgur.com/WTEq4Zv.png)
