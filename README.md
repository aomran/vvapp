# Voix Visuelle Project

This rails application is being created to ease the administrative process at the art gallery - Voix Visuelle. Right now artists mail in their work and application forms on a CD/DVD. A lot of manual work is involved during the processing of these submissions. The goal is to automate as much of this process as possible.

Artists will be able to create accounts and store their personal information. They are then given the opportunity to make their submissions to the shows online.

The admin team at Voix Visuelle will have most of the work already done for them by the rails application, they can focus on evaluating the work and making decisions.

# To-do:
## Menu bar functionality
* ~~Make the calling of the pre-method check_user_login more universal~~ Done.
* ~~Finish implementing the menu bar functionality Paula was working on:~~
	* ~~On profile page, if currently logged-on user has a submission in progress, the menu bar should give access to **Editez Soumission**; otherwise, the menu bar should give access to **Créez Soumission**.~~ Decided to not implement in order to keep UI streamlined.
* ~~More menu bar functionality: for example root menu bar should allow possibility to access profile, to access submission, if the user is logged on, instead of leaving them with nowhere to go but to log off.~~ Instead, redefined root path to point to profile.
* More menu bar functionality: to be thought about.

## More navigation
* ~~Breadcrumbs -- Étape 1 (profile), 2 (text documents submission), 3 (images)~~ Implemented for steps 1 and 2.
* ~~Put Étape 3 de 3 (menu bar 2/3 full) when user starts submitting images.~~
* Étape 3 de 3 (menu bar 3/3 full) when images are all in.
* ~~Notification of completion~~
* ~~Way for user to finalize submission/step 3; a way for user and app to do a sort of handshake, agreeing on one side that the submission is valid; on the other side that the user considers themselves done. Link could set a field in submission object of "complete." (They can still return to edit submission if they want)~~

##Profile
* ~~Change Femme/Homme to a radio button~~ Done

## Document Submission
* ~~Make file uploads in submissions~~

##Image loader
* The image-saving button currently named "Déposer soumission" on the submission show page should be renamed "Ajouter Images" and it should only appear if JS is disabled
* Image loader needs explanations, french text
* ~~The ability to remove images needs to be added~~
* ~~Adding images should not be on the display submission page but rather on a new (or add) images page~~
* ~~A list of filenames of images should be displayed as well as the thumbnails~~

##Validations
* For images: type, number, size (pixel dimensions min/max; filesize max), possibly filename format, uniqueness of filename.
* Others: presence of all the profile info; some basic checks perhaps. Presence of all the required documents.

##Admin
* Notably, the restriction of access to appropriate pages


##Processing of data collected
* This can in principle -- as long as we are confident that what we want to do is feasible -- wait or be refined later; the first priority is to get the submissions-receiving end up in September, so that we can open submisisons
* Ahmed notes that it could be both nicer and at the same time easier to implement if we do things in a more modern way (nice display of data) rather than insisting that the process mirror the existing way of doing things (producing a CSV file of the artist data and a folder of folders of artist documents and images)
* Need to discuss this with Shahla