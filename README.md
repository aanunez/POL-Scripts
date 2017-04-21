# POL-Scripts
Play On Linux scripts I have written

The "icons" and "screenshot" folders are only used for archival here. They are required when submitting scripts to POL. Scripts tagged as "NOT POL Approved" do not have working icons.

**Working**

* Viscera Cleanup Detail - Can be used to install VCD, the DLC "House of Horrors" and the two spin off games "Santa's Rapage" and "Shadow Warrior". [Not POL Approved]

* Star Wars Battle Front 2 - Used to install the BattleFront2 version on steam. Runs without issue, but load times are a little slow (~30 seconds, they are around 5-10 on Windows).

**Installing**

* Starcraft 1.18 - Blizzard has released starcraft for free, this script will fetch and install it. Currently only StarEdit (map maker) works, SC bombs out with ... err:module:attach_process_dlls "ClientSdk.dll" failed to initialize, aborting . This appears to be a dll used by the blizzard agent, some on appDB have reported getting it to work with wine-overwatch, but I have had no such luck.

* Starcraft 1.18 PTR - Blizzard is releasing starcraft for free. Its currently still in beta (PTR), but this script will fetch and install it. Currently only StarEdit (map maker) works, SC bombs out when trying to download an update from blizz.

* The Day The World Broke - Disc is not found by wine at run time. I assume this is due to some DRM.

* Titanic: Adventure Out of Time - Game runs, but colors are not correct. Not playable. WineHQ reports this as working 7 years ago. Documented in the script is a breif explination of the issue.

**Not Working**

* Star Trek Elite Force 1 - This game works when installed manually using wine 2.5. When using the script a "Keyfile dll" error is shown when installing the expansion pack.

**Untested/Defunct**

* World of Warcraft 1.12.1 Private Server

* Starcraft 1.18 PTR - SC 1.18 is out of PTR. Blizzard is releasing starcraft for free. Its currently still in beta (PTR), but this script will fetch and install it. Currently only StarEdit (map maker) works, SC bombs out when trying to download an update from blizz.

**In The Works**

* Muppet Treasure Island
* Star Trek Elite Force 2
* Star Trek Armada 1 & 2
