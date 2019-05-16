
# Golang S2I builder image 

## Create the builder image
The following command will create a builder image named golang-builder based on the Dockerfile that was created previously.
```
docker build -t golang-builder .
```
The builder image can also be created by using the *make* command since a *Makefile* is included.

Once the image has finished building, the command *s2i usage golang-builder* will print out the help info that was defined in the *usage* script.

## Creating the application image
The application image combines the builder image with your applications source code, which is served using whatever application is installed via the *Dockerfile*, compiled using the *assemble* script, and run using the *run* script.
The following command will create the application image:
```
s2i build <git_url_to_source_code> golang-builder golang-builder-app
---> Building and installing application from source...
```
Using the logic defined in the *assemble* script, s2i will now create an application image using the builder image as a base and including the source code from your git repository. 

## Running the application image
Running the application image is as simple as invoking the docker run command:
```
docker run -d golang-builder-app
```
Don't forget to add the rights parapeters (specific to your application) to the command above.
