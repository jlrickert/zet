# Database data management for MySQL with Navicat

- For a GUI use Navicat.

## Steps to copy over data from another database

WARNING!!! Make sure you don't overwrite the wrong target.

- Create the connection to the 2 databases
- Have the tables list from the source database
- Highlight and copy the tables and copy to past buffer
- Go to the target database and paste over

  This should open up a wizard to configure what you want to copy over

## Backing up data

There are 2 methods that Navicat gives you. One is through an SQL dump, and the other is Backup feature part of Navicat.

- SQL Method

  The SQL dump is more compatible. To make right click the database you want to back up and select Dump SQL File. Save to some file. This can then be used to restore. Something to note: freakin slow to restore. Like hours.

- Navicat Backup

  The other method is the Backup features. This makes a backup on you local machine. To backup do the thing.
