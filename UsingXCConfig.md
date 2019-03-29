## <img src="./Images/img-xcode.png" height="30"> Using Xcode Configuration File (.xcconfig) to Manage Different Build Settings

_Written by: **Nguyen Minh Tam**_

### Related topics:
- Working with multiple Targets. [See detail][Targets].
- Working with multiple Targets and Scheme using `*.xcconfig`. [See detail][Xcconfig].
- How to config the setting of application and how to handle it by using `Settings.bundle`. [See detail][Settings].

[Targets]: ./WorkingWithMultipleTargets.md
[Xcconfig]: ./UsingXCConfig.md
[Settings]: ./UsingSettingsBundle.md

During the development lifecycle of a software project, you probably create different builds at various stages. At the early stage, there will be the one that conforms to your local configuration. When you are ready to move to the next stage, there is another build that will be utilized by your QA group to test the features and bug fixes. When the app passes all tests and got the QA team’s approval, you will create another version which is sent to your customers for beta test before pushing it to App Store. At last, there will be the production-ready application, once the client is satisfied with the build that you have sent. All of these builds are not exactly the same, each of which usually has some specialties and a slightly different configuration.

For example, if the app needs to connect to a backend, it is very likely the app is connected to the test environment during QA tests. The build is probably configured with a test URL. When you move to the next stage, the other build will have another URL for connecting to the staging/production server. On top of that, you may not be showing the same level of information when an error occurs in the application for all the builds.

### How Can You Manage Multiple Builds?

First way: Create different targets, each one of which employs different Info.plist. Each time a target is selected, a different Info.plist will be used, hence we will be able to differentiate variables like token, URLs for different builds.

Second way: Using Bundle Identifiers. Defining different preprocessor macros will control the conditional compilation of various chunks of code.

Third way: put your build configuration settings into .xcconfig files and refer those in your project info. Then you can build a different version of an app by simply changing the scheme. Putting build configuration settings into files is a huge win for configuration management.

### Creating the Build Configuration

Select file Project in Project Navigator > Select Project > Choose tab Info > you should see that Xcode already provides you two different configuration levels: Debug and Release.

Now we are going to create a new configuration. Let’s just call it “Staging”. Click on the + sign right beneath the configuration list and select “Duplicate Debug configuration” as it’s much easier to remove the things we don’t want from the Debug configuration than putting back in those we need to the Release configuration.

### Using Xcode Configuration File (.xcconfig)

As mentioned we use Xcode configuration file (.xcconfig) instead of using conditional compilation blocks to manage the build settings (such as which tokens, api keys, urls of backends should be used).

Xcode Configuration file (.xcconfig) is, it is actually a key/value based file. You can store your build settings in the form of key/value pairs, similar to what you did in dictionaries. By using a .xcconfig file, it is very easy to define build parameters for each build. You will understand what I mean in a while.

Create a .xcconfig file. In the project navigator, right click the project folder and chooose New file…. In the dialog that pops up, select the Configurations Settings File. In the next screen, give it the name “Staging” and make sure the targets checkboxes are all unchecked, because you don’t want to include this in your app’s bundle.

Now go to your project’s info screen, under the configurations section expand the list and select the xcconfile “Staging” from the drop down box.

Once done, you can repeat the process for the main target and choose the Debug file. Also, repeat the process for the Release Target.

### Changing the Build Information

You want to change the build information like app name, app version, bundle identifier, and bundle version for each build, you can edit each of the .xcconfig file like this:

```
Debug.xcconfig:

IS_APP_NAME = Donate Debug
IS_APP_VERSION = 0.3
IS_APP_BUNDLE_ID = com.intensifystudio.DonateDebug
```

Use your configuration variables in project settings, info.plist and entitlement files.

```
Bundle name: $(IS_APP_NAME)
```

For clarity, I am using a custom prefix “IS” for IntensifyStudio as the name of my little development studio to distguish the custom key from the default one.

> Note: Changing the bundle identifier will require you to create more provisioning profiles.

### Changing App Icon

Go to Build Settings and replace AppIcon with the variable ${IS_APP_ICON}

### Accessing Variables from Code

Add variables to Info.plist by creating additional fields

```
func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
 }
```

### Switching Between Build Configurations

To switch between build configurations, you can simply change the scheme by holding the option key and click on the scheme at the top. You can then select your preferred build configuration.

**Reference:**
> [Using Xcode Configuration File (.xcconfig) to Manage Different Build Settings](https://www.appcoda.com/xcconfig-guide/)