# Voix Visuelle Project

This rails application is being created to ease the administrative process at the art gallery - Voix Visuelle. Right now artists mail in their work and application forms on a CD/DVD. A lot of manual work is involved during the processing of these submissions. The goal is to automate as much of this process as possible.

Artists will be able to create accounts and store their personal information. They are then given the opportunity to make their submissions to the shows online.

The admin team at Voix Visuelle will have most of the work already done for them by the rails application, they can focus on evaluating the work and making decisions.

# Still to-do:
## Document Submission
* The Edit submissions page should display the currently uploaded document filenames (if easily done)

## Error handling
* Work on making French translation of errors as fail-proof as possible
* ~~Edit profile: with password filled in and confirm pw not filled in, gives error "First argument in form cannot contain nil or be empty". Same thing if pw and confirm pw don't match~~

## Password changing/reset
* there should be some pw reset functionality for ppl who have forgotten pw

##Jury Accounts
* Limited (read-only) admin accounts for jury members need to be set up.

##Video
* Put up validation (and text describing criteria) for video file types etc once Shahla has decided what she wants.

##Final implementation:
* Amazon S3 file handling
* Put it live on a server
* Put in text/link on main VV site pointing to it

# Archive: everything below is all done!!!
### Menu bar functionality
* Make the calling of the pre-method check_user_login more universal
* Finish implementing the menu bar functionality Paula was working on:
	* On profile page, if currently logged-on user has a submission in progress, the menu bar should give access to **Editez Soumission**; otherwise, the menu bar should give access to **Créez Soumission**. Decided to not implement in order to keep UI streamlined.
* More menu bar functionality: for example root menu bar should allow possibility to access profile, to access submission, if the user is logged on, instead of leaving them with nowhere to go but to log off.Instead, redefined root path to point to profile.

### More navigation
* Breadcrumbs -- Étape 1 (profile), 2 (text documents submission), 3 (images)
* Put Étape 3 de 3 (progress bar 2/3 full) when user starts submitting images.
* Étape 3 de 3 (progress bar 3/3 full) when images are all in, i.e., when Finalisez Soumission is clicked? When complete tag is true, progress bar becomes full and green and there is a "Merci, soumission complète!" title replacing the Etapes title -- on all screens that have a progress bar.
* Notification of completion
* Way for user to finalize submission/step 3; a way for user and app to do a sort of handshake, agreeing on one side that the submission is valid; on the other side that the user considers themselves done. Link could set a field in submission object of "complete." (They can still return to edit submission if they want)
* Made homesite and document links open on new pages
* Made Continuez Soumission button (on profile page) read Revisez Soumission if the sub is complete
* In addition to "On any page where the user is logged on, that isn't the profile page, there is a profile link in the menu bar now" as below, there is also a "Retournez aux Document" buttons on the image page
* Added "Retournez aux Documents", "Profile", and also "Retournez aux Image" to menu bar for all states where submission is complete; also in that case they show which of those is active.

###Profile
* Change Femme/Homme to a radio button

### Document Submission
* Make file uploads in submissions
* The Edit submissions page should not break if the user changes their mind and clicks "enregistrer modifications" without having made any modifications.
* How does one access the profile page from the submissions pages? On any page where the user is logged on, that isn't the profile page, there is a profile link in the menu bar now.

###Image loader
* The image-saving button currently named "Déposer soumission" on the submission show page should be renamed "Ajouter Images" and it should only appear if JS is disabled
* Image loader needs explanations, french text
* The ability to remove images needs to be added
* Adding images should not be on the display submission page but rather on a new (or add) images page
* A list of filenames of images should be displayed as well as the thumbnails

###Validations
* For images: type, size (pixel dimensions min/max; filesize max), uniqueness of filename.
* Others: presence of all the profile info. Presence of all the required documents.
* Handle/display-to-user validation failures: Displayed and internationalized.
* Number of images? As per discussion with Shahla, we are omitting this.

###Admin
* Notably, the restriction of access to appropriate pages
* Ability, at the minimum, to be able to delete accounts; other "housekeeping" capabilities.

###Processing of data collected
* This can in principle -- as long as we are confident that what we want to do is feasible -- wait or be refined later; the first priority is to get the submissions-receiving end up in September, so that we can open submisisons
* Ahmed notes that it could be both nicer and at the same time easier to implement if we do things in a more modern way (nice display of data) rather than insisting that the process mirror the existing way of doing things (producing a CSV file of the artist data and a folder of folders of artist documents and images)
* We have a nice UI now, and the ability to produce a csv digest of user info. Remains to be discussed with Shahla whether we need to produce a zip file of artist documents and images.

* The csv export is formatted

### Misc
* Work in minor changes suggested by Shahla
