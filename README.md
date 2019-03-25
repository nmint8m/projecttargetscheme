# Demo Set Up Project With Multiple Target

**Menu**

- [Demo Xcode “Targets” with multiple build configurations](#demo-xcode-targets-with-multiple-build-configurations)

## Demo Xcode “Targets” with multiple build configurations

How to create multiple applications that differentiate and share parts of the source code

### Why do I need this?

- Build one version of your app for iPhone and another specific version for iPad, need to share some part of your code and customize others things: screen layout, presentation behaviors
- Big company that has some independent business units and desires to build just one app for these companies, some business rules can be different for each business unit.

### How can I achieve this goal?

> A target specifies a product to build and contains the instructions for building the product from a set of files in a project or workspace.
 
with a Target, there are many default configurations, in this case when you duplicate a Target, you are making a clone of it. After that, you can change bundle identifier, deployment info, display name, app icons source, and so on. 

So, another powerful thing that a Target provides is the possibility to create a resource with the same name for each Target you have. Notice in the picture above, the project has two files declaring a class called Product, in a normal situation it will produce a compilation error, but using Target, you can assign each file to a specific Target. Look at the image below, you select the file and define the Target.

### A common mistake

When you are working with Target it is very common to create a resource and forget to assign more than one Target, later when you try to compile, you get an error saying that that resource does not exist, so you look in the source code tree and file is there, but it is not been included in the selected target, believe me, I already spent some minutes trying to understand what was wrong.

### Step by step

- Create new / duplicate target no transfer iPad
- Rename first target and second target: ONE, TWO
- Config each target:
	- In target ONE, going to Build Setting, add a User-defined Setting with this dictionary:
	
```
ENPOINT_URL
Debug: http://debug.productone.nmint8m.dev
Release: http://productone.nmint8m.dev
``` 
 
	- Do similarly for target ProductTwo and check the property `Info.plist File` is the same path as ProductOne
- In file Info.plist create a property:

```
ENPOINT_URL: $(ENDPOINT_URL)
```

- Config scheme for ProductTwo -> target ProductTwo

- The last step, get the property:

```
class Config {
    static var endpoint: String {
        get {
            guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
                let dic = NSDictionary(contentsOfFile: path),
                let endpoint = dic["ENDPOINT_URL"] as? String else { return "" }
            return endpoint
        }
    }
}
```

When we build with target:

- ProductOne -> print `debug.productone.t8m.dev`
- ProductTwo -> print `debug.producttwo.t8m.dev`

[Xcode “Targets” with multiple build configurations](https://medium.com/@andersongusmao/xcode-targets-with-multiples-build-configuration-90a575ddc687)

### AppIcon for each target

- Create file *.xassets for each target
- Import AppIcon
- Choose target in project, set AppIcon in General.

### Change Bundle Indentifier

- Change Bundle Identifier for each target

### Some Notes on Managing Multiple Targets

1. When you add new files to the project, don’t forget to select both targets to keep your code in sync in both builds.
2. In case you’re using Cocoapods, don’t forget to add the new target to your podfile. You can use link_with to specify multiple targets. You can further consult the Cocoapods documentation for details. Your podfile should look something like this:

```bash
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'
workspace 'todo'
link_with 'todo', 'todo Dev'
pod 'Mixpanel'
pod 'AFNetworking'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '7.0'
workspace 'todo'
link_with 'todo', 'todo Dev'
pod 'Mixpanel'
pod 'AFNetworking'
```

3. If you use continuous integration system such as Travis CI or Jenkins, don’t forget to configure to build and deliver both targets.

[How to Use Xcode Targets to Manage Development and Production Builds](https://www.appcoda.com/using-xcode-targets)

