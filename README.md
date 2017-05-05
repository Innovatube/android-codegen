# android-codegen
#### New MVP Project Wizard
Create new MVP Project by using new project wizard:
You have to modify `app/build.gradle` and download `google-service.json` before building your project
```groovy
apply plugin: 'com.android.application' 
apply plugin: 'realm-android' //top level
apply plugin: 'com.neenbedankt.android-apt' //top level
```
Please see the attached file

![New MVP Project Wizard](/art/new-project.gif)

#### Create MVP Project from plugin menu

First, you have to create empty project, without any Activity
![New Project](/art/add-no-activity.png)
Open new menu & select `Generat MVP Project`
![New Project](/art/new-menu.png)
Simply press Finish`
![New Project](/art/update-mvp-project.png)

#### Login
Open new menu & select `Generate Login Activity`
![New Project](/art/login-activity.png)  
Similar to `Generate MVP Fragment/MVP Activity/View and Presenter`

#### Generate Adapter
Open your layout file, right click and select `Generate`
![New Project](/art/generate-adapter-action.png)  
Copy paste!  
![New Project](/art/generate-adapter-code.png)

### How to create new template
Android Studio use [FreeMarker](http://freemarker.org/) to generate code from template.  
Template's structure:
```
template
│   template.xml       //description, parameters
│   recipe.xml.ftl     //instruction to copy, merge...
│   globals.xml.ftl    //global variables
|   template.png       //template thumbnail
|   template_foo.png   //template thumbnail
└───root               //source code 
│   └───res
│   │   |   ...
│   └───src
│       │   source1.java.ftl
│       │   source2.java.ftl
```

#### template.xml
```xml
<?xml version="1.0"?>
<template
    format="5" //use template format version 5
    revision="6" //your template revision
    name="Tabbed Activity" //your template name
    minApi="13" //minimum api for your template
    minBuildApi="14" //minimum build api for your template
    requireAppTheme="true" //your template requires your existing project have apptheme
    description="Creates a new blank activity, with an action bar and navigational elements such as tabs or horizontal swipe.">
    <category value="Activity" /> //category, optional if you want to include it into plugin
    <formfactor value="Mobile" /> 
    <parameter
        id="activityClass" //id, ${activityClass} presents its value
        name="Activity Name" 
        type="string" //it can be enum, string, boolean
        constraints="class|unique|nonempty" //restriction for this param: nonempty/apilevel/package/class/activity/layout/drawable/string/id/unique/exist
        suggest="${layoutToActivity(layoutName)}" //suggestion
        default="MainActivity" //default value
        help="The name of the activity class to create" />
    <thumbs>
      <thumb>template.png</thumb> //default thumbnail
      <thumb foo="bar">template_foo.png</thumb> //thumbnail will show template_foo when foo is bar
    </thumbs>
</template>
```

### globals.xml.ftl
```xml
<?xml version="1.0"?>
<globals>

    <#include "../common/common_globals.xml.ftl" />

    <global id="featureName" value="${classToResource(className)?cap_first}"/>
</globals>
```
Optional xml file contains global variable definitions.

### recipe.xml.ftl
`recipe.xml.ftl` contains instruction that should be execute when generate template
```xml
<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/TemplatePresenter.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${presenterName}.java" />
    <instantiate from="root/src/app_package/TemplateMvpView.java.ftl"
                 to="${escapeXmlAttribute(srcOut)}/${viewName}.java" />

    <open file="${escapeXmlAttribute(srcOut)}/${presenterName}.java" />
    <open file="${escapeXmlAttribute(srcOut)}/${viewName}.java" />
</recipe>
```
The availalbe instruction are:
- `<copy from="from" to="to"/>` (Copy directly without FreeMarker)
- `<instantiate from="from" to="to"/>` (Copy with FreeMarker)
- `<merge from="from" to="to"/>` (merge `from` into `to` with FreeMarker)
- `<open file="file"/>` (open `file` in IDE)
- `<classpath mavenUrl="url"/>` (add `url` as classpath to build.gradle)
- `<dependency mavenUrl="url"/>` (add `url` as dependency to app/build.gradle)
- `<apply plugin="url"/>` (add `apply plugin: url` to **END** of app/build.gradle)  

Android plugin also comes up with some extra functions:
- activityToLayout(string) //MainActivity becomes activity_main
- camelCaseToUnderscore(string) //MainActivity becomes main_activity
- classToResource(string) //stripping Fragment or Activty then lowercase, MainActivity becomes main
- layoutToActivity(string) //activity_main becomes MainActivity
- slashedPackageName(string) //com.innovatube.example becomes com/innovatube/example
- underscoreToCamelCase(string) //main_activity becomes MainActivity
- applicationPackage //present application package name
